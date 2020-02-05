class Product
  attr_accessor :code, :category, :price

  def initialize(code:, category:, price:)
    @code = code
    @category = category
    @price = price
  end

  def self.all
    (1..10).map do |num|
      new(
        code: "HOSP202#{num}", category: num>5 ? 'Linux' : 'Windows',
        price: Random.new(50)
      )
    end
  end

end