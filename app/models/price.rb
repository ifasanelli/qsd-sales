class Price
  attr_accessor :name, :id, :valor, :float_value

  def initialize(id: 0, name: '', valor: '', float_value: 0)
    @name = name
    @id = id
    @valor = valor
    @float_value = float_value
  end

  def self.all
    [new(id: 1, name: '1 Mes', valor: 'R$: 10,00', float_value: 10),
     new(id: 3, name: '3 Meses', valor: 'R$: 30,00', float_value: 30),
     new(id: 6, name: '6 Meses', valor: 'R$: 60,00', float_value: 60),
     new(id: 9, name: '9 Meses', valor: 'R$: 90,00', float_value: 90),
     new(id: 12, name: '12 Meses', valor: 'R$: 120,00', float_value: 120)]
  end

  def self.find(price_id)
    @price = all.detect { |price| price.id == price_id }
  end

  def expose
    "#{name} - #{valor}"
  end
end
