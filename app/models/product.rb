class Product
  attr_accessor :name, :id

  def initialize(id: 0, name: 'Jonas')
    @name = name
    @id = id
  end

  def self.all
    [new(id: 1, name: 'Hospedagem Linux'),
     new(id: 2, name: 'Hospedagem Windows')]
  end
end
