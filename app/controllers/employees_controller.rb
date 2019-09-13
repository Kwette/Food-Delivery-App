require_relative "../models/employee"
require_relative "../repositories/employee_repository"
require_relative "../views/employee_view"

class EmployeesController
  def initialize(employee_repository)
    @employee_view = EmployeeView.new
    @employee_repository = employee_repository
  end

  def list
    # get list of recipes
    employees = @employee_repository.all
    # send list to the view
    @employee_view.display_list(employees)
  end

  def add
    # ask user for name
    username = @employee_view.ask_user_for("username")
    # ask user for decription
    password = @employee_view.ask_user_for("password")
    # ask user for role
    role = @employee_view.ask_user_for("role")
    # create recipe
    employee = Employee.new(username: username, password: password, role: role)
    # add to cookbook
    list << employee
    list
  end
end
