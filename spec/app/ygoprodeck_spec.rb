require 'ygoprodeck'

RSpec.describe 'Ygoprodeck::Fname' do
	it 'Test Lib ygoprodeck = True' do
		atem = Ygoprodeck::Fname.is('Dark Magician')
		expect(atem['name']).to eq('Dark Magician')
	end
	
	it 'Test Lib ygoprodeck = False' do
		atem = Ygoprodeck::Fname.is('jancok raimu')
		expect(atem).to be_nil
	end
	puts '- lib ygoprodeck'
end
