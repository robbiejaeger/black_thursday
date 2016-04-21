require 'pry'
require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants, :sales_engine_object


  def initialize(csv_filepath, sales_engine_object)
    @merchants = []
    @sales_engine_object = sales_engine_object
    create_merchants(csv_filepath)
  end

  def all
    @merchants
  end

  def find_items_by_merchant_id(id)
    @sales_engine_object.find_items_by_merchant_id(id)
  end

  def find_by_id(id)
    @merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    @merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    @merchants.find_all { |merchant| merchant.name.downcase.include?(name.downcase) }
  end

  def find_all_invoices_by_merchant_id(id)
    @sales_engine_object.find_all_invoices_by_merchant_id(id)
  end

  private

  def create_merchants(csv_filepath)
    parse_csv_data(csv_filepath)
  end

  def parse_csv_data(csv_filepath)
    contents = CSV.open(csv_filepath, headers: true, header_converters: :symbol)
    contents.each do |row|
      id = row[:id]
      name = row[:name]
      created_at = row[:created_at]
      updated_at = row[:updated_at]

      create_merchant_hash(id, name, created_at, updated_at)
    end
  end

  def create_merchant_hash(id, name, created_at, updated_at)
    merchant_creation_hash = {}
    merchant_creation_hash[:id] = id
    merchant_creation_hash[:name] = name
    merchant_creation_hash[:created_at] = created_at
    merchant_creation_hash[:updated_at] = updated_at
    merchant_creation_hash
    add_merchant(merchant_creation_hash)
  end

  def add_merchant(merchant_creation_hash)
    @merchants << Merchant.new(merchant_creation_hash, self)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
