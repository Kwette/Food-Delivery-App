require 'csv'
require_relative "../models/order"

class OrderRepository
  attr_accessor :id
  attr_reader :orders_csv_path, :meal_repository, :employee_repository, :customer_repository
  def initialize(orders_csv_path, meal_repository, employee_repository, customer_repository)
    @orders_csv_path = orders_csv_path
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
    @orders = []
    @next_id = 1
    load_csv if File.exist?(orders_csv_path)
  end

  def all
    @orders
  end

  def undelivered_orders
    undelivered = []
    @orders.each do |order|
      undelivered << order if order.delivered? == false
    end
    return undelivered
  end

  def find_undelivered_by_employee_id(employee)
    undelivered_orders.select { |element| element.employee.id == employee.id }
  end

  def add(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_csv
  end

  def mark_as_delivered(employee)
    order_id = @order_view.ask_for_id("order")
    order = @order_repository.find(order_id)
    order.deliver!
    save_csv
  end

  def find(id)
    @orders.find { |order| order.id == id }
  end


  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@orders_csv_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      row[:delivered] = row[:delivered] == "true"
      order = Order.new(row)
      @orders << order && @orders.empty? ? @next_id = 1 : @next_id = @orders.count + 1
    end
  end

  def save_csv
    CSV.open(@orders_csv_path, "wb") do |row|
      row << ["id", "customer_id", "meal_id", "employee_id", "delivered"]
      @orders.each do |order|
        row << [order.id, order.customer.id, order.meal.id, order.employee.id, order.delivered]
      end
    end
  end
end
