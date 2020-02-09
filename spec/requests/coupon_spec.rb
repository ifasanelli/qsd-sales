require 'rails_helper'

describe 'Find coupon' do
  context 'show' do
    it 'successfully' do
      coupon = Coupon.find('NATLOCA01')
      expect(coupon.name).to eq('NATLOCA01')
      expect(coupon.discount).to eq(0.3)
    end
  end
end
