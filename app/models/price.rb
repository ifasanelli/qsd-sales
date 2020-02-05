class Price
  attr_accessor :name, :id

  def initialize(id: 0, name: '', valor: 0)
    @name = name
    @id = id
    @valor = valor
  end

  def self.all
    [new(id: 1, name: '1 Mes', valor: '10 pila'),
    new(id: 3, name: '3 Meses', valor: '30 pila'),
    new(id: 6, name: '6 Meses', valor: '60 pila'),
    new(id: 9, name: '9 Meses', valor: '90 pila'),
    new(id: 12, name: '12 Meses', valor: '120 pila')]
  end

  def self.find(price_id)
    @price = all.detect { |price| price.id == price_id}
  end
end
