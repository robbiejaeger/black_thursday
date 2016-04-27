require 'csv'
require_relative "../lib/invoice_item"

class InvoiceItemRepository

  attr_reader :invoice_items, :sales_engine_object

  def initialize(csv_filepath, sales_engine_object)
    @sales_engine_object = sales_engine_object
    @invoice_items = []
    create_invoice_items(csv_filepath) unless csv_filepath.nil?
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    @invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  private

  def create_invoice_items(csv_filepath)
    parse_csv_data(csv_filepath)
  end

  def parse_csv_data(csv_filepath)
    contents = CSV.open(csv_filepath, headers: true, header_converters: :symbol)
    contents.each do |row|
      invoice_item_creation_hash = {}

      invoice_item_creation_hash[:id] = row[:id]
      invoice_item_creation_hash[:item_id] = row[:item_id]
      invoice_item_creation_hash[:invoice_id] = row[:invoice_id]
      invoice_item_creation_hash[:quantity] = row[:quantity]
      invoice_item_creation_hash[:unit_price] = row[:unit_price]
      invoice_item_creation_hash[:created_at] = row[:created_at]
      invoice_item_creation_hash[:updated_at] = row[:updated_at]

      add_invoice_item(invoice_item_creation_hash)
    end
  end

  def add_invoice_item(invoice_item_creation_hash)
    @invoice_items << InvoiceItem.new(invoice_item_creation_hash, self)
  end

  # :nocov:
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
  # :nocov:

end
