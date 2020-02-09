require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#find' do
    it 'find price for id' do
      product = Product.new(id: 1, name: 'Hospedagem')
      result = Product.find(product.id)

      expect(result.id == product.id).to eq(true)
    end
  end
end
