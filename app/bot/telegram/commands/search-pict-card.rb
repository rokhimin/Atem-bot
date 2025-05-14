
class Pict
  def self.link(from)
    atem = Ygoprodeck::Fname.is(from)

    return "https://i.imgur.com/lPSo3Tt.jpg" if atem.nil? || atem["id"].nil?

    Ygoprodeck::Image.is(atem["id"])
  end
end
