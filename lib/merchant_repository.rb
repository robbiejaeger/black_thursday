require 'pry'
require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :all_merchants

  def initialize(csv_filepath)
    @merchants = []
    create_merchants(csv_filepath)
  end

  def all  #returns an array of all known Merchant instances
    @merchants
  end

  def find_by_id(id) ##returns either nil or an instance of Merchant with a matching ID
    index = @merchants.find_index { |merchant| merchant.id == id }
    if index != nil
      @merchants[index]
    else
      nil
    end
  end

  def find_by_name(name)
    index = @merchants.find_index { |merchant| merchant.name.downcase == name.downcase }
    if index != nil
      @merchants[index]
    else
      nil
    end
  end

  def find_all_by_name(name)
    @merchants.find_all { |merchant| merchant.name.downcase.include?(name.downcase) }
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
    @merchants << Merchant.new(merchant_creation_hash)
  end
end
