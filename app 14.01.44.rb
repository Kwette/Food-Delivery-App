# TODO: require relevant files to bootstrap the app.
# Then you can test your program with:
#   ruby app.rb
require_relative 'app/models/meal'
require_relative 'app/repositories/meal_repository'
require_relative 'app/controllers/meals_controller'
require_relative 'router'

csv_file = 'data/meals.csv'

meal_repository = MealRepository.new(csv_file)
meals_controller = MealsController.new(meal_repository)

require_relative 'app/models/customer'
require_relative 'app/repositories/customer_repository'
require_relative 'app/controllers/customers_controller'

csv_file = 'data/customers.csv'

customer_repository = CustomerRepository.new(csv_file)
customers_controller = CustomersController.new(customer_repository)

require_relative 'app/models/employee'
require_relative 'app/repositories/employee_repository'
require_relative 'app/controllers/employees_controller'

csv_file = 'data/employees.csv'

employee_repository = EmployeeRepository.new(csv_file)
employees_controller = EmployeesController.new(employee_repository)

require_relative 'app/models/order'
require_relative 'app/repositories/order_repository'
require_relative 'app/controllers/orders_controller'

orders_csv_path = 'data/order.csv'

order_repository = OrderRepository.new(orders_csv_path, meal_repository, employee_repository, customer_repository)
orders_controller = OrdersController.new(meal_repository, employee_repository, customer_repository, order_repository)



router = Router.new(meals_controller, customers_controller, employees_controller, orders_controller)

# # Start the app
router.run
