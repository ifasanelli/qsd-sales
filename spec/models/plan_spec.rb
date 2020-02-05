require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe '#find' do
    it 'find plan for id' do
      plan = Plan.new(id: 1, name: 'Linux')

      result = Plan.find(plan.id)

      expect(result.id == plan.id).to eq(true)
    end
  end
end
