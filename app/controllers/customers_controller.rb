require_relative "../models/customer"
require_relative "../repositories/customer_repository"
require_relative "../views/customer_view"

class CustomersController
  def initialize(repository)
    @customer_view = CustomerView.new
    @repository = repository
  end

  def list
    # get list of recipes
    customers = @repository.all
    # send list to the view
    @customer_view.display_list(customers)
  end

  def add
    # ask user for name
    name = @customer_view.ask_user_for("name")
    # ask user for decription
    address = @customer_view.ask_user_for("address")
    # create recipe
    customer = Customer.new(name: name, address: address)
    # add to cookbook
    @repository.add(customer)
    # display tasklist
    list
  end
end
