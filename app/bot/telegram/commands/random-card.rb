
class Random
  def self.message
				atem = Ygoprodeck::Card.random

				id = atem["id"]
				name = atem["name"]
				type = atem["type"]
				attribute = atem["attribute"]
				level = atem["level"]
				race = atem["race"]
				desc = atem["desc"]
				m_atk = atem["atk"]
				m_def = atem["def"]
				about = []
			
				"*id* : #{id} \n*name* : #{name} \ntype : #{type} \n"
  end
	
	def self.pict
				atem = Ygoprodeck::Card.random
				id = atem["id"]
		
				Ygoprodeck::Image.is(id)
	end
end