# TODO: implement the router of your app.
class Router
  def initialize(meals_controller, customers_controller, employees_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @employees_controller = employees_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    puts "Welcome to Delivery_food!"
    puts "           --           "

    while @running
      display_tasks
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @employees_controller.list
    when 6 then @employees_controller.add
    when 7 then @orders_controller.list
    when 8 then @orders_controller.add
    when 9 then stop
    else
      puts "Please press 1, 2, 3, 4, 5, 6, 7, 8 or 9"
    end
  end

  def stop
    @running = false
  end

  def display_tasks
    puts "What do you want to do next?"
    puts "1 - List all meals"
    puts "2 - Create a new meal"
    puts "3 - List all customers"
    puts "4 - Create a new customer"
    puts "5 - List all employee"
    puts "6 - Create a new employee"
    puts "7 - List all orders"
    puts "8 - Create a new order"
    puts "9 - Stop and exit the program"
  end
end
