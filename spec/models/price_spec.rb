require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '.get_periodicities' do
    it 'should get all periodicities' do
      url = 'http://localhost:3000/api/v1/periodicities'
      json_file = File.read(
          Rails.root.join('spec/support/jsons/periodicity_index.json')
      )
      double_response = double('faraday_response', body: json_file,
                                                    status: 200)

      allow(Faraday).to receive(:get).with(url).and_return(double_response)

      result = Price.get_periodicities

      expect(result.length).to eq 4
      expect(result[0][:name]).to eq 'Mensal'
    end
  end

  describe '.all' do
    it 'should get all prices' do
      url_periodicities = 'http://localhost:3000/api/v1/periodicities'
      url_prices = 'http://localhost:3000/api/v1/plans/1/prices'
      json_file_periodicities = File.read(
          Rails.root.join('spec/support/jsons/periodicity_index.json')
      )
      json_file_prices = File.read(
          Rails.root.join('spec/support/jsons/price_index.json')
      )
      double_response_periodicities = double('faraday_response', body: json_file_periodicities,
                                                   status: 200)
      double_response_prices = double('faraday_response', body: json_file_prices,
                                                   status: 200)

      allow(Faraday).to receive(:get).with(url_periodicities).and_return(double_response_periodicities)
      allow(Faraday).to receive(:get).with(url_prices).and_return(double_response_prices)


      result = Price.all

      expect(result.length).to eq 3
      expect(result[0].periodicity_name).to eq 'Mensal'
    end
  end
end
