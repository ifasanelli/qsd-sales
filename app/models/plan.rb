class Plan
  attr_accessor :name, :id

  def initialize(id: 0, name: '')
    @name = name
    @id = id
  end

  def self.all
    [new(id: 1, name: 'Linux'),
     new(id: 2, name: 'Windows')]
  end

  def self.find(plan_id)
    @plan = all.detect { |plan| plan.id == plan_id }
  end
end
