require "csv"
require_relative "../lib/invoice_item"

class InvoiceItemRepository

  attr_reader :invoice_items, :sales_engine_object

  def initialize(csv_filepath, sales_engine_object)
    @sales_engine_object = sales_engine_object
    @invoice_items = []
    create_invoice_items(csv_filepath)
  end

  def all
    @invoice_items
  end

  private

  def create_invoice_items(csv_filepath)
    parse_csv_data(csv_filepath)
  end

  def parse_csv_data(csv_filepath)
    contents = CSV.open(csv_filepath, headers: true, header_converters: :symbol)
    contents.each do |row|
      id = row[:id]
      item_id = row[:item_id]
      invoice_id = row[:invoice_id]
      quantity = row[:quantity]
      unit_price = row[:unit_price]
      created_at = row[:created_at]
      updated_at = row[:updated_at]

      create_invoice_item_hash(id, item_id, invoice_id, quantity, unit_price, created_at, updated_at)
    end
  end

  def create_invoice_item_hash(id, item_id, invoice_id, quantity, unit_price, created_at, updated_at)
    invoice_item_creation_hash = {}
    invoice_item_creation_hash[:id] = id
    invoice_item_creation_hash[:item_id] = item_id
    invoice_item_creation_hash[:invoice_id] = invoice_id
    invoice_item_creation_hash[:quantity] = quantity
    invoice_item_creation_hash[:unit_price] = unit_price
    invoice_item_creation_hash[:created_at] = created_at
    invoice_item_creation_hash[:updated_at] = updated_at
    invoice_item_creation_hash
    add_invoice_item(invoice_item_creation_hash)
  end

  def add_invoice_item(invoice_item_creation_hash)
    @invoice_items << InvoiceItem.new(invoice_item_creation_hash, self)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
