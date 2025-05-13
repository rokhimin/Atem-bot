import { BaileysClass } from '../../../lib/baileys.js';
import fetch from 'node-fetch';

const botBaileys = new BaileysClass({});

botBaileys.on('auth_failure', async (error) => console.log("ERROR BOT: ", error));
botBaileys.on('qr', (qr) => console.log("NEW QR CODE: ", qr));
botBaileys.on('ready', async () => console.log('READY BOT'))
const formatPattern = /:: *(.*?) *::/;

async function fetchCardData(cardName: string): Promise<{ info: string, imageUrl?: string }> {
    try {
        const encodedName = encodeURIComponent(cardName);
        const response = await fetch(`https://db.ygoprodeck.com/api/v7/cardinfo.php?fname=${encodedName}`);
        const data: any = await response.json();

        if (data.error) {
            return { info: `Card not found: ${cardName}` };
        }

        const card = data.data[0];
        let cardInfo = `*${card.name}*\n`;
        cardInfo += `Type: ${card.type}\n`;
        if (card.attribute) cardInfo += `Attribute: ${card.attribute}\n`;
        if (card.level) cardInfo += `Level/Rank: ${card.level}\n`;
        if (card.race) cardInfo += `Race: ${card.race}\n`;
        if (card.atk !== undefined) cardInfo += `ATK: ${card.atk}\n`;
        if (card.def !== undefined) cardInfo += `DEF: ${card.def}\n`;
        if (card.linkmarkers !== undefined) cardInfo += `Linkmarkers: ${card.linkmarkers}\n`;
        cardInfo += `\n*Card Text*\n${card.desc}\n`;

        const imageUrl = card.card_images?.[0]?.image_url_cropped;
        return { info: cardInfo, imageUrl };
    } catch (error) {
        console.error('Error fetching card data:', error);
        return { info: 'Error fetching card data. Please try again later.' };
    }
}

botBaileys.on('message', async (message) => {
    const isGroup = message.from.endsWith('@g.us');
    const match = message.body.match(formatPattern);

    // information bot
    if (message.body.toLowerCase() === ':atem') {
        await botBaileys.sendText(message.from, '*Atem* (version 1.0.0)\nCreated and Developed by 089612893953 (whdzera)\n\n*Usage*\n- :status => information Latency Sever Bot\n- ::name card:: => search yugioh card\n\n*Donation*\nhttps://saweria.co/whdzera');
    }

    // Status Latency API and Server
    if (message.body.toLowerCase() === ':status') {
      const start = Date.now();

      let apiLatency: string;
      try {
        const res = await fetch('https://db.ygoprodeck.com/api/v7/cardinfo.php?name=dark%20magician');
        const json = await res.json();
        const end = Date.now();
        apiLatency = json?.data?.[0]?.id ? `${end - start}ms.` : 'ERROR';
      } catch (err) {
        apiLatency = 'ERROR';
      }

      const serverLatency = Date.now() - start;

      const messageStatus = `*Status*\n- Server latency: ${serverLatency - 40}ms.\n- API latency: ${apiLatency}`;
      await botBaileys.sendText(message.from, messageStatus);
    }

    // Search yugioh card in group
    if (isGroup && match) {
        const extractedText = match[1];
        const result = await fetchCardData(extractedText);
        if (result.imageUrl) {
            await botBaileys.sendMedia(message.from, result.imageUrl, result.info);
        }
        else
            await botBaileys.sendText(message.from, 'Card Not Found');
    }
    
});
