class Coupon
  attr_accessor :code, :valid, :discount

  def initialize(code:, valid:, discount:)
    @code = code
    @valid = valid
    @discount = discount
  end

  def self.all
    (1..10).map do |num|
      new(code: "CARNA00#{num}", valid: false, discount: Random.new(50))
    end
  end

end