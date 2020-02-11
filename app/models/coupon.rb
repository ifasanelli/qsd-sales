class Coupon
  attr_reader :name, :discount
  def initialize(name: '', discount: 0)
    @name = name
    @discount = discount
  end

  def self.all
    [new(name: 'NATLOCA01', discount: 21),
     new(name: 'NATLOCA02', discount: 21)]
  end

  def self.find(name)
    @coupon = all.detect { |coupon| coupon.name == name }
  end
end
