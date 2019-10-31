
class Duellinksmeta
  def self.message
		
      url = Nokogiri::HTML(open("https://www.duellinksmeta.com/tier-list"))
				
			date = ''
            date << url.css('h4')[0]

			#tier1 
			tier1 = []
			count1 = 7
			t1_default = 0
			for logic_tier1 in 1..7 do
				main1 = url.css('div.button-row')[0]
				works1 = main1.css('span.decktype-display')[t1_default].to_s 
				tier1 << works1.gsub(/<\/?[^>]+>/, '')
				t1_default += 1
				count1 -= 1
			end

			#tier2
			tier2 = []
			count2 = 7
			t2_default = 0
			for logic_tier2 in 1..7 do
				main2 = url.css('div.button-row')[1]
				works2 = main2.css('span.decktype-display')[t2_default].to_s 
				tier2 << works2.gsub(/<\/?[^>]+>/, '')
				t2_default += 1
				count2 -= 1
			end

			#tier3
			tier3 = []
			count3 = 7
			t3_default = 0
			for logic_tier3 in 1..7 do
				main3 = url.css('div.button-row')[2]
				works3 = main3.css('span.decktype-display')[t3_default].to_s 
				tier3 << works3.gsub(/<\/?[^>]+>/, '')
				t3_default += 1
				count3 -= 1
			end
		
		  	"*#Tier1:*\n#{tier1.join(", ")}\n*#Tier2:*\n#{tier2.join(", ")}\n*#Tier3:*\n#{tier3.join(", ")}\n-------------------\n#{date} | source : DuelLinksMeta.com"
		
	end
end
