require 'rails_helper'

RSpec.describe Price, type: :model do
  describe '.all' do
    it 'should get all prices' do
      url = 'http://localhost:3000/api/v1/plans/1/prices'
      json_file = File.read(
          Rails.root.join('spec/support/jsons/price_index.json')
      )
      double_response = double('faraday_response', body: json_file,
                                                   status: 200)
      allow(Faraday).to receive(:get).with(url).and_return(double_response)

      result = Price.all

      expect(result.length).to eq 3
      expect(result[0].expose).to eq 'CincoAnos - R$ 4.356,87'
      expect(result[1].expose).to eq 'SeisAnos - R$ 5.351,09'
      expect(result[2].expose).to eq 'SeteAnos - R$ 6.129,13'
    end

    it 'should return an empty array if API return error' do
      url = 'http://localhost:3000/api/v1/plans/1/prices'
      double_response = double('faraday_response', status: 500)

      allow(Faraday).to receive(:get).with(url).and_return(double_response)

      result = Price.all

      expect(result.length).to eq 0
    end
  end

  describe '.find' do
    it 'find a price successfully' do
      url = 'http://localhost:3000/api/v1/plans/1/prices'
      json_file = File.read(
        Rails.root.join('spec/support/jsons/price_index.json')
      )
      double_response = double('faraday_response', body: json_file,
                                                   status: 200)

      allow(Faraday).to receive(:get).with(url).and_return(double_response)

      result = Price.find(1)

      expect(result.expose).to eq('CincoAnos - R$ 4.356,87')
    end

    it 'find not return result' do
      url = 'http://localhost:3000/api/v1/plans/1/prices'
      double_response = double('faraday_response', status: 500)
      allow(Faraday).to receive(:get).with(url).and_return(double_response)

      result = Price.find(1)

      expect(result.nil?).to be_truthy
    end
  end
end
