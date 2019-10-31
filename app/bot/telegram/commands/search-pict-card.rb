
class Pict
		attr_reader :from
  def self.link(from)
			atem = Ygoprodeck::Fname.is(from)
		
			if atem["id"] == nil
				"https://i.imgur.com/lPSo3Tt.jpg"
			else
				Ygoprodeck::Image.is(atem['id'])
			end
	end
end