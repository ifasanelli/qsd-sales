class Price
  include ActionView::Helpers::NumberHelper
  attr_accessor :name, :id, :valor, :float_value

  def initialize(id: 0, name: '', valor: '', float_value: 0)
    @name = name
    @id = id
    @valor = valor
    @float_value = float_value
  end

  def self.all
    [new(id: 1, name: '1 Mes', float_value: 10),
     new(id: 3, name: '3 Meses', float_value: 30),
     new(id: 6, name: '6 Meses', float_value: 60),
     new(id: 9, name: '9 Meses', float_value: 90),
     new(id: 12, name: '12 Meses', float_value: 120)]
  end

  def self.api_version
    'v1'
  end

  def self.endpoint
    Rails.configuration.qsd_apis[:coupon_url]
  end

  def self.product_url
    "#{endpoint}/api/#{api_version}"
  end

  def self.discount(coupon_name, price, product_id)
    request_url = "#{product_url}/coupons/confer?coupon=:#{coupon_name}" \
                  "&price=:#{price}&product=:#{product_id}"
    response = Faraday.get(request_url)

    json = JSON.parse(response.body, symbolize_names: true)

    return json[:error] if response.status == 422 || response.status == 404

    @float_value = price - json[:discount].to_i
  end

  def self.find(price_id)
    @price = all.detect { |price| price.id == price_id }
  end

  def expose
    "#{name} - #{number_to_currency(float_value)}"
  end
end
