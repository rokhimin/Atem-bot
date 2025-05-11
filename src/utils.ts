import { rename, createWriteStream, existsSync, readFileSync, promises as fsPromises   } from 'fs'
import { tmpdir } from 'os'
import followRedirects, { HttpOptions, HttpClient, HttpsOptions, HttpsClient } from 'follow-redirects';
import path from 'path';
import crypto from 'crypto';
import mime from 'mime-types';
import { extname } from 'path';
import ffmpeg from 'fluent-ffmpeg';


import sharp from 'sharp';
import { readFile } from 'fs';
import qr from 'qr-image';


const { http, https } = followRedirects;

interface HttpResponse {
    response: {
        headers: {
            'content-type': string
        }
    },
    fullPath: string
}

const utils = {
    formatPhone: (contact: string, full: boolean = false): string => {
        let domain = contact.includes('@g.us') ? '@g.us' : '@s.whatsapp.net';
        contact = contact.replace(domain, '');
        return !full ? `${contact}${domain}` : contact;
    },
    generateRefprovider: (prefix: string = ''): string => prefix ? `${prefix}_${crypto.randomUUID()}` : crypto.randomUUID(),
    isValidNumber: (rawNumber: string): boolean => !rawNumber.match(/\@g.us\b/gm),
    prepareMedia: (media: string): { url: string } | { buffer: Buffer } => {
        if (utils.isUrl(media)) {
            return { url: media };
        } else {
            try {
                return { buffer: readFileSync(media) };
            } catch (e) {
                console.error(`Failed to read file at ${media}`, e);
                throw e;
            }
        }
    },
    isUrl: (s: string): boolean => {
        try {
            new URL(s);
            return true;
        } catch {
            return false;
        }
    },
    generalDownload: async (url: string): Promise<string> => {
        const checkIsLocal = existsSync(url)

        const handleDownload = (): Promise<HttpResponse> => {
            const checkProtocol = url.includes('https:')
            const handleHttp = checkProtocol ? https : http

            const name = `tmp-${Date.now()}-dat`
            const fullPath = `${tmpdir()}/${name}`
            const file = createWriteStream(fullPath)

            if (checkIsLocal) {
                /**
                 * From Local
                 */
                return new Promise((res) => {
                    const response = {
                        headers: {
                            'content-type': mime.contentType(extname(url)) || 'application/octet-stream',
                        },
                    }
                    res({ response, fullPath: url })
                })
            } else {
                /**
                 * From URL
                 */
                return new Promise((res, rej) => {
                    handleHttp.get(url, function (response) {
                        response.pipe(file)
                        file.on('finish', async function () {
                            file.close()
                            res({ response, fullPath })
                        })
                        file.on('error', function () {
                            file.close()
                            rej(null)
                        })
                    })
                })
            }
        }

        const handleFile = (pathInput: string, ext: string): Promise<string> =>
            new Promise((resolve, reject) => {
                const fullPath = `${pathInput}.${ext}`
                rename(pathInput, fullPath, (err) => {
                    if (err) reject(null)
                    resolve(fullPath)
                })
            })

        const httpResponse = await handleDownload()
        const { ext } = await utils.fileTypeFromFile(httpResponse.response)
        const getPath = await handleFile(httpResponse.fullPath, ext)

        return getPath
    },
    convertAudio: async (filePath: string = '', format: string = 'opus'): Promise<string> => {
        const formats = {
            mp3: {
                code: 'libmp3lame',
                ext: 'mp3',
            },
            opus: {
                code: 'libopus',
                ext: 'opus',
            },
        }

        const opusFilePath = path.join(path.dirname(filePath), `${path.basename(filePath, path.extname(filePath))}.${formats[format].ext}`)
        await new Promise((resolve, reject) => {
            ffmpeg(filePath)
                .audioCodec(formats[format].code)
                .audioBitrate('64k')
                .format(formats[format].ext)
                .output(opusFilePath)
                .on('end', resolve)
                .on('error', reject)
                .run()
        })
        return opusFilePath
    },
    fileTypeFromFile: async (response: { headers: { 'content-type': string } }): Promise<{ type: string, ext: string | any }> => {
        const type = response.headers['content-type'] ?? null
        const ext = mime.extension(type)
        return {
            type,
            ext,
        }
    },
    baileyGenerateImage: async (base64, name = 'qr.png') => {
        const PATH_QR = `${process.cwd()}/${name}`
        let qr_svg = qr.image(base64, { type: 'png', margin: 4 })

        const writeFilePromise = () =>
            new Promise((resolve, reject) => {
                const file = qr_svg.pipe(createWriteStream(PATH_QR))
                file.on('finish', () => resolve(true))
                file.on('error', reject)
            })

        await writeFilePromise()
        await utils.cleanImage(PATH_QR)
    },
    cleanImage: async (FROM: string): Promise<boolean> => {
        const readBuffer = async (): Promise<Buffer> => {
            const data = await fsPromises.readFile(FROM)
            return Buffer.from(data)
        }
    
        const imgBuffer: Buffer = await readBuffer()

        return new Promise((resolve, reject) => {
            sharp(imgBuffer, { failOnError: false })
                .extend({
                    top: 15,
                    bottom: 15,
                    left: 15,
                    right: 15,
                    background: { r: 255, g: 255, b: 255, alpha: 1 },
                })
                .toFile(FROM, (err) => {
                    if (err) reject(err)
                    resolve(true)
                })
        })
    }


}

export default utils;
