require 'csv'
require_relative '../lib/item'

class ItemRepository

  attr_reader :items, :sales_engine_object

  def initialize(csv_filepath, sales_engine_object)
    @sales_engine_object = sales_engine_object
    @items = []
    create_items(csv_filepath) unless csv_filepath.nil?
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find {|item| item.id == id}
  end

  def find_by_name(name)
    @items.find {|item| item.name.downcase == name.downcase}
  end

  def find_all_with_description(string)
    @items.find_all {|item| item.description.downcase.include?(string.downcase)}
  end

  def find_all_by_price(price)
    @items.find_all {|item| item.unit_price_to_dollars == price}
  end

  def find_all_by_price_in_range(range)
    @items.find_all {|item| range === item.unit_price_to_dollars}
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all {|item| item.merchant_id == merchant_id}
  end

  def find_merchant_by_merchant_id(merchant_id)
    @sales_engine_object.find_merchant_by_merchant_id(merchant_id)
  end

  private

  def create_items(csv_filepath)
    parse_csv_data(csv_filepath)
  end

  def parse_csv_data(csv_filepath)
    contents = CSV.open(csv_filepath, headers: true, header_converters: :symbol)
    contents.each do |row|
      item_creation_hash = {}

      item_creation_hash[:id] = row[:id]
      item_creation_hash[:name] = row[:name]
      item_creation_hash[:description] = row[:description]
      item_creation_hash[:unit_price] = row[:unit_price]
      item_creation_hash[:merchant_id] = row[:merchant_id]
      item_creation_hash[:created_at] = row[:created_at]
      item_creation_hash[:updated_at] = row[:updated_at]

      add_item(item_creation_hash)
    end
  end

  def add_item(item_creation_hash)
    @items << Item.new(item_creation_hash, self)
  end

  # :nocov:
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
  # :nocov:

end
