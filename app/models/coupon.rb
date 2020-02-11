class Coupon
  attr_reader :name, :discount
  def initialize(name: '', discount: 0)
    @name = name
    @discount = discount
  end

  def self.all
    response = Faraday.get('http://localhost:3000/api/v1/coupon')

    return [] if response.status == 500

    json = JSON.parse(response.body, symbolize_names: true)

    coupon_list = []
    json.each do |item|
      coupon_list << Coupon.new(item[:name], item[:discount])
    end

    coupon_list
  end

  def self.find(name)
    @coupon = all.detect { |coupon| coupon.name == name }
  end
end
