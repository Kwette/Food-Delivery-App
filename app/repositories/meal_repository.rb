require 'csv'
require_relative "../models/meal"

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @meals
  end

  def add(meal)
    meal.id = @next_id
    @next_id += 1
    @meals << meal
    save_csv
  end

  def find(id)
    @meals.find { |meal| meal.id == id }
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      meal = Meal.new(row)
      @meals << meal
    end

    @meals.empty? ? @next_id = 1 : @next_id = @meals.count + 1
  end

  def save_csv
    CSV.open(@csv_file_path, "wb") do |row|
      row << ["id", "name", "price"]
      @meals.each do |meal|
        row << [meal.id, meal.name, meal.price]
      end
    end
  end
end
