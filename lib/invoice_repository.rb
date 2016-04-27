require "csv"
require_relative "../lib/invoice"

class InvoiceRepository

  attr_reader :sales_engine_object, :invoices

  def initialize(csv_filepath, sales_engine_object)
    @sales_engine_object = sales_engine_object
    @invoices = []
    create_invoices(csv_filepath) unless csv_filepath.nil?
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    @invoices.find_all { |invoice| invoice.status.downcase == status.downcase }
  end

  def find_merchant_by_merchant_id(merchant_id)
    @sales_engine_object.find_merchant_by_merchant_id(merchant_id)
  end

  def find_invoice_items_by_id(id)
    @sales_engine_object.find_invoice_items_by_id(id)
  end

  def find_transactions_by_invoice_id(id)
    @sales_engine_object.find_transactions_by_invoice_id(id)
  end

  def find_customer_by_customer_id(customer_id)
    @sales_engine_object.find_customer_by_customer_id(customer_id)
  end

  def sum_all_items_and_quanities(id)
    @sales_engine_object.sum_all_items_and_quanities(id)
  end

  private

  def create_invoices(csv_filepath)
    parse_csv_data(csv_filepath)
  end

  def parse_csv_data(csv_filepath)
    contents = CSV.open(csv_filepath, headers: true, header_converters: :symbol)
    contents.each do |row|
      invoice_creation_hash = {}

      invoice_creation_hash[:id] = row[:id]
      invoice_creation_hash[:customer_id] = row[:customer_id]
      invoice_creation_hash[:merchant_id] = row[:merchant_id]
      invoice_creation_hash[:status] = row[:status]
      invoice_creation_hash[:created_at] = row[:created_at]
      invoice_creation_hash[:updated_at] = row[:updated_at]

      add_invoice(invoice_creation_hash)
    end
  end

  def add_invoice(invoice_creation_hash)
    @invoices << Invoice.new(invoice_creation_hash, self)
  end

  # :nocov:
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
  # :nocov:

end
