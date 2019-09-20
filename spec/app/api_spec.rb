require 'ostruct'
require 'yaml'
require 'open-uri'
require 'net/http'
require 'json'
# TEST API
RSpec.describe do
  CONFIG = OpenStruct.new YAML.load_file 'config/config.yaml'
				url = "#{CONFIG.api}dark magician"
				uri = URI(url)
				response = Net::HTTP.get(uri)
				atem = JSON.parse(response)
	it 'test main API' do
		expect(atem[0]["name"]).to eq("Dark Magician")
	end
end
