require 'csv'
require_relative "../models/employee"

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @employees
  end

  def all_delivery_guys
    @employees.reject { |employee| employee.manager? }
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end



  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:username] = row[:username]
      row[:password] = row[:password]
      row[:role] = row[:role]
      employee = Employee.new(row)
      @employees << employee
    end

    @employees.empty? ? @next_id = 1 : @next_id = @employees.count + 1
  end

  def save_csv
    CSV.open(@csv_file_path, "wb") do |row|
      row << ["id", "name", "address"]
      @employees.each do |employee|
        row << [employee.id, employee.username, employee.password, employee.role]
      end
    end
  end
end
