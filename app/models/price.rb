class Price
  attr_accessor :name, :id

  def initialize(id: 0, name: '', valor: 0)
    @name = name
    @id = id
    @valor = valor
  end

  def self.all
   [new(id: 1, name: '1 Mes', valor: 'R$: 10,00'),
    new(id: 3, name: '3 Meses', valor: 'R$: 30,00'),
    new(id: 6, name: '6 Meses', valor: 'R$: 60,00'),
    new(id: 9, name: '9 Meses', valor: 'R$: 90,00'),
    new(id: 12, name: '12 Meses', valor: 'R$: 120,00')]
  end

  def self.find(price_id)
    @price = all.detect { |price| price.id == price_id}
  end
end
