class EmployeeView
  def ask_user_for(data)
    puts "What is the #{data} of your employee ?"
    gets.chomp
  end

  def display_list(employees)
    employees.each do |employee|
      # done = recipe.done? ? "[X]" : "[ ]"
      puts "Employee n° #{employee.id} - #{employee.username} : #{employee.password} - #{employee.role}"
    end
  end
end
