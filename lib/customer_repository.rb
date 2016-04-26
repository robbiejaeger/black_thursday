require 'csv'
require_relative "../lib/customer"

class CustomerRepository

  attr_reader :sales_engine_object, :invoices

  def initialize(csv_filepath, sales_engine_object)
    @sales_engine_object = sales_engine_object
    @customers = []
    create_customers(csv_filepath) unless csv_filepath.nil?
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find { |customer| customer.id == id }
  end

  def find_all_by_first_name(first_name)
    @customers.find_all do |name|
      name.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    @customers.find_all do |name|
      name.last_name.downcase.include?(last_name.downcase)
    end
  end

  def find_all_merchants_by_customer_id(id)
    @sales_engine_object.find_all_merchants_by_customer_id(id)
  end

  private

  def create_customers(csv_filepath)
    parse_csv_data(csv_filepath)
  end

  def parse_csv_data(csv_filepath)
    contents = CSV.open(csv_filepath, headers: true, header_converters: :symbol)
    contents.each do |row|
      id = row[:id]
      first_name = row[:first_name]
      last_name = row[:last_name]
      created_at = row[:created_at]
      updated_at = row[:updated_at]

      create_customer_hash(id, first_name, last_name, created_at, updated_at)
    end
  end

  def create_customer_hash(id, first_name, last_name, created_at, updated_at)
    customer_creation_hash = {}
    customer_creation_hash[:id] = id
    customer_creation_hash[:first_name] = first_name
    customer_creation_hash[:last_name] = last_name
    customer_creation_hash[:created_at] = created_at
    customer_creation_hash[:updated_at] = updated_at
    add_customer(customer_creation_hash)
  end

  def add_customer(customer_creation_hash)
    @customers << Customer.new(customer_creation_hash, self)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
