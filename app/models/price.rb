class Price
  include ActionView::Helpers::NumberHelper
  attr_accessor :id, :plan_price, :plan_id, :periodicity

  def initialize(id, plan_price, plan_id, periodicity)
    @id = id
    @plan_price = plan_price
    @plan_id = plan_id
    @periodicity = periodicity
  end

  def self.all
    response = Faraday.get('http://localhost:3000/api/v1/plans/1/prices')
    return [] if response.status == 500
    
    json = JSON.parse(response.body, symbolize_names: true)

    result = []
    json.each do |item|
      result << Price.new(item[:id], item[:plan_price],
                            item[:plan_id], item[:periodicity])
    end
    result
  end

  def self.find(price_id)
    @price = all.detect { |price| price.id == price_id }
  end

  def expose
    "#{periodicity} - #{number_to_currency(plan_price)}"
  end
end
