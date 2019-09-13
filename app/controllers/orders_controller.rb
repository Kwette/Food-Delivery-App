require_relative "../models/order"
require_relative "../repositories/order_repository"
require_relative "../views/order_view"
require 'csv'


class OrdersController
  attr_reader :order_repository, :meal_repository, :employee_repository, :customer_repository

  def initialize(meal_repository, employee_repository, customer_repository, order_repository)
    @order_view = OrderView.new
    @order_repository = order_repository
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
  end

  def list
    # get list of recipes
    orders = @order_repository.all
    # send list to the view
    @order_view.display_list(orders)
  end

  def list_my_orders(employee)
    orders = @order_repository.find_undelivered_by_employee_id(employee)
    @order_view.display_undelivered(orders)
  end

  def list_undelivered_orders
    undelivered = @order_repository.undelivered_orders
    # send list to the view
    @order_view.display_undelivered(undelivered)
  end

  def mark_as_delivered(employee)
    @order_repository.find_undelivered_by_employee_id(employee)
    order_id = @order_view.ask_for_order_id
    @order_repository.find(order_id).deliver!
    @order_repository.save_csv
  end

  def add
    ask_for_user_data
    objects_from_repos
    create_order
  end

  private

  def ask_for_user_data
    @meal_id = @order_view.ask_for_meal_id
    @employee_id = @order_view.ask_for_employee_id
    @customer_id = @order_view.ask_for_customer_id
  end

  def objects_from_repos
    @meal     = meal_repository.find(@meal_id)
    @employee = employee_repository.find(@employee_id)
    @customer = customer_repository.find(@customer_id)
  end

  def create_order
    order = Order.new(meal: @meal, employee: @employee, customer: @customer)
    @order_repository.add(order)
  end
end
