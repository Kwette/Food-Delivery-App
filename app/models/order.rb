class Order
  attr_reader :customer, :meal, :delivered, :employee
  attr_accessor :id

  def initialize(attributes = {})
    @customer = attributes[:customer]
    @meal = attributes[:meal]
    @employee = attributes[:employee]
    @id = attributes[:id]
    @delivered = attributes[:delivered] || false
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end
