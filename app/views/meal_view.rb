class MealView
  def ask_user_for(data)
    puts "What is the #{data} of your meal ?"
    gets.chomp
  end

  def display_list(meals)
    meals.each do |meal|
      # done = recipe.done? ? "[X]" : "[ ]"
      puts "Meal n°#{meal.id} - #{meal.name} : #{meal.price}"
    end
  end
end


