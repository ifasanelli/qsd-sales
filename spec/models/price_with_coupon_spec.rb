require 'rails_helper'

RSpec.describe Price, type: :model do
  describe '.discount' do
    it 'should get a valid coupon via API' do
      price = Price.new(id: 3, name: '3 Meses', float_value: 30)
      product = Product.new(1, 'Hospedagem')
      coupon = Coupon.new(name: 'NATLOCA01')
      url = 'http://localhost:4000/api/v1/coupons/confer?coupon=:' \
            "#{coupon.name}&price=:#{price.float_value}&product=:#{product.id}"
      json_file = File.read(
        Rails.root.join('spec/support/jsons/valid_coupon.json')
      )
      double_response = double('faraday_response', body: json_file,
                                                   status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(double_response)

      result = Price.discount(coupon.name, price.float_value, product.id)

      expect(result).to eq 20
    end

    it 'should return an error message if invalid coupon' do
      price = Price.new(id: 3, name: '3 Meses', float_value: 30)
      product = Product.new(1, 'Hospedagem')
      coupon = Coupon.new(name: 'NATLOCA01')
      url = 'http://localhost:4000/api/v1/coupons/confer?coupon=:' \
             "#{coupon.name}&price=:#{price.float_value}&product=:#{product.id}"
      json_file = File.read(
        Rails.root.join('spec/support/jsons/invalid_coupon.json')
      )
      double_response = double('faraday_response', body: json_file,
                                                   status: 422)
      allow(Faraday).to receive(:get).with(url).and_return(double_response)

      result = Price.discount(coupon.name, price.float_value, product.id)

      expect(result).to eq 'Cupom inválido para o produto especificado'
    end

    it 'should return an error message if coupon doesnt exists' do
      price = Price.new(id: 3, name: '3 Meses', float_value: 30)
      product = Product.new(1, 'Hospedagem')
      coupon = Coupon.new(name: 'NATLOCA01')
      url = 'http://localhost:4000/api/v1/coupons/confer?coupon=:' \
             "#{coupon.name}&price=:#{price.float_value}&product=:#{product.id}"
      json_file = File.read(
        Rails.root.join('spec/support/jsons/inexistent_coupon.json')
      )
      double_response = double('faraday_response', body: json_file,
                                                   status: 404)
      allow(Faraday).to receive(:get).with(url).and_return(double_response)

      result = Price.discount(coupon.name, price.float_value, product.id)

      expect(result).to eq 'Cupom inexistente'
    end
  end
end
