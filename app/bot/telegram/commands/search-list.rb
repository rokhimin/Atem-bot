class Searchlist
		attr_reader :from
  def self.message(from)
		
				atem = Ygoprodeck::List.is(from)
		
				if atem[0]['id'] == nil				
					"0 card matches for *#{from}*\n try again aibou.."
					
				else
					listing = []
					count = 25
					num_default = 0
					for logic_search in 1..25 do
						if atem[num_default] == nil
						else
						listing << atem[num_default]["name"]
						num_default += 1
						count -= 1
						end
					end
		  			
					atem_listing = listing.shuffle
					"#{listing.length} card matches for *#{from}*\n#{atem_listing.join(" \n")}"
			 
				end
	end
end