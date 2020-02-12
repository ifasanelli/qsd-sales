class Coupon
  attr_reader :name, :discount, :status
  def initialize(name: '', discount: 0, status: '')
    @name = name
    @discount = discount
    @status = status
  end

  def self.all
    [new(name: 'NATLOCA01', discount: 21),
     new(name: 'NATLOCA02', discount: 21)]
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

  def self.burn(code)
    request_url = "#{product_url}/coupon/#{code}/burn"
    response = Faraday.get(request_url)

    json = JSON.parse(response.body, symbolize_names: true)

    return [] if response.status == 404

    @status = json[:status]
  end

  def self.find(name)
    @coupon = all.detect { |coupon| coupon.name == name }
  end
end
