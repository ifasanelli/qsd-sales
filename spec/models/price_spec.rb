require 'rails_helper'

RSpec.describe Price, type: :model do
  describe '#find' do
    it 'find price for id' do
      price = Price.new(id: 3, name: '3 Meses', valor: 'R$: 30,00')

      result = Price.find(price.id)

      expect(result.id == price.id).to eq(true)
    end
  end
end
