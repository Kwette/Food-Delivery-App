require_relative "../models/meal"
require_relative "../repositories/meal_repository"
require_relative "../views/meal_view"

class MealsController
  def initialize(meal_repository)
    @meal_view = MealView.new
    @meal_repository = meal_repository
  end

  def list
    # get list of recipes
    meals = @meal_repository.all
    # send list to the view
    @meal_view.display_list(meals)
  end

  def add
    # ask user for name
    name = @meal_view.ask_user_for("name")
    # ask user for decription
    price = @meal_view.ask_user_for("price").to_i
    # create recipe
    meal = Meal.new(name: name, price: price)
    # add to cookbook
    @meal_repository.add(meal)
    # display tasklist
    list
  end
end
