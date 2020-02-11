class Price
  include ActionView::Helpers::NumberHelper
  attr_accessor :id, :plan_price, :plan_id, :periodicity_name

  def initialize(id, plan_price, plan_id, periodicity_name)
    @id = id
    @plan_price = plan_price
    @plan_id = plan_id
    @periodicity_name = periodicity_name
  end

  def self.all
    periodicities = get_periodicities

    response = Faraday.get('http://localhost:3000/api/v1/plans/1/prices')
    json = JSON.parse(response.body, symbolize_names: true)
    return [] if response.status == 500

    result = []
    json.each do |item|
      name = periodicities.find { |period| period[:id] == item[:periodicity_id] }[:name]
      result << Price.new(item[:id], item[:plan_price],
                            item[:plan_id], name)
    end

    result
  end

  def self.find(price_id)
    @price = all.detect { |price| price.id == price_id }
  end

  def expose
    "#{periodicity_name} - #{number_to_currency(plan_price)}"
  end

  def self.get_periodicities
    periodicity_url = 'http://localhost:3000/api/v1/periodicities'
    response = Faraday.get(periodicity_url)
    return [] if response.status == 500

    json = JSON.parse(response.body, symbolize_names: true)
  end

end
