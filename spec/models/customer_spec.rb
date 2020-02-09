require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe '#indentification' do
    it 'should create a full description of car' do
      customer = build(:customer)
      result = customer.identification
      expect(result).to eq "#{customer.name} - #{customer.document}"
    end
  end
end
