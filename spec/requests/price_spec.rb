require 'rails_helper'

describe 'Find price' do
  context 'Find price sended' do
    xit 'successfully' do
      price = Price.find(3)
      expect(price.expose).to eq('3 Meses - R$ 30,00')
      expect(price.name).to eq('3 Meses')
      expect(price.float_value).to eq(30)
    end
  end
end
