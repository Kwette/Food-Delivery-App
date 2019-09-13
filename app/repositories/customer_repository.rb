require 'csv'
require_relative "../models/customer"

class CustomerRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @customers = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @customers
  end

  def add(customer)
    @customers << customer
    customer.id = @next_id
    @next_id += 1
    save_csv
  end

  def find(id)
    @customers.find { |customer| customer.id == id }
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:name] = row[:name].to_s
      row[:address] = row[:address].to_s
      customer = Customer.new(row)
      @customers << customer
    end

    @customers.empty? ? @next_id = 1 : @next_id = @customers.count + 1
  end

  def save_csv
    CSV.open(@csv_file_path, "wb") do |row|
      row << ["id", "name", "address"]
      @customers.each do |customer|
        row << [customer.id, customer.name, customer.address]
      end
    end
  end
end
