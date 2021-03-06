class Product
  attr_accessor :name, :id

  def initialize(id: 0, name: 'Cluster')
    @name = name
    @id = id
  end

  def self.all
    [new(id: 1, name: 'Hospedagem'),
     new(id: 2, name: 'Cloud')]
  end

  def self.find(product_id)
    @product = all.detect { |product| product.id == product_id }
  end
end
