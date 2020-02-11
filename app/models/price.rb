class Price
  include ActionView::Helpers::NumberHelper
  attr_accessor :id, :plan_price, :plan_id, :periodicity

  def initialize(id, plan_price, plan_id, periodicity)
    @id = id
    @plan_price = plan_price
    @plan_id = plan_id
    @periodicity = periodicity
  end

  def self.api_version
    'v1'
  end

  def self.endpoint
    Rails.configuration.qsd_apis[:product_url]
  end

  def self.product_url
    "#{endpoint}/api/#{api_version}"
  end

  def self.all(plans)
    prices = []
    plans.each do |plan|
      prices += find_by(plan_id: plan.id)
    end
    prices
  end

  def self.find_by(plan_id:)
    request_url = "#{product_url}/plans/#{plan_id}/prices"
    response = Faraday.get(request_url)

    return [] if response.status == 500

    json = JSON.parse(response.body, symbolize_names: true)

    result = []
    json.each do |item|
      result << Price.new(item[:id], item[:plan_price],
                          item[:plan_id], item[:periodicity])
    end
    result
  end

  def self.find(plan_id:, price_id:)
    @price = find_by(
      plan_id: plan_id
    ).detect { |price| price.id == price_id }
  end

  def expose
    "#{periodicity} - #{number_to_currency(plan_price)}"
  end
end
