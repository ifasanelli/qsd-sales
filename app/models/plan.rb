class Plan
  attr_accessor :name, :id

  def initialize(id, name)
    @name = name
    @id = id
  end

  def self.all
    response = Faraday.get('http://localhost:3000/api/v1/plans')

    return [] if response.status == 500

    json = JSON.parse(response.body, symbolize_names: true)

    result = []
    json.each do |item|
      result << Product.new(item[:id], item[:name])
    end
    result
  end

  def self.find(plan_id)
    @plan = all.detect { |plan| plan.id == plan_id }
  end
end
