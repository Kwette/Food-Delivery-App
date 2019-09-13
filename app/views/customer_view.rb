class CustomerView
  def ask_user_for(data)
    puts "What is the #{data} of your customer ?"
    gets.chomp
  end

  def display_list(customers)
    customers.each do |customer|
      # done = recipe.done? ? "[X]" : "[ ]"
      puts "Customer n° #{customer.id} - #{customer.name} : #{customer.address}"
    end
  end
end
