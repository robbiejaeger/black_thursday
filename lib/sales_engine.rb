require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items, :transactions, :customers

  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self)
    @invoices = InvoiceRepository.new(hash[:invoices], self)
    @merchants = MerchantRepository.new(hash[:merchants], self)
    @invoice_items = InvoiceItemRepository.new(hash[:invoice_items], self)
    @transactions = TransactionRepository.new(hash[:transactions], self)
    @customers = CustomerRepository.new(hash[:customers], self)
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  def find_items_by_merchant_id(id)
    @items.find_all_by_merchant_id(id)
  end

  def find_all_invoices_by_merchant_id(id)
    @invoices.find_all_by_merchant_id(id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def find_invoice_items_by_id(id)
    @invoice_items.find_all_by_invoice_id(id).map do |invoice_item|
      @items.find_by_id(invoice_item.item_id)
    end
  end

  def find_transactions_by_invoice_id(id)
    @transactions.find_all_by_invoice_id(id)
  end

  def find_customer_by_customer_id(customer_id)
    @customers.find_by_id(customer_id)
  end

  def find_invoice_by_invoice_id(invoice_id)
    @invoices.find_by_id(invoice_id)
  end

  def find_all_customers_for_merchant(id)
    @invoices.find_all_by_merchant_id(id).map do |invoice|
      @customers.find_by_id(invoice.customer_id)
    end.uniq{|customer| customer.id}
  end

  def find_all_merchants_by_customer_id(id)
    @invoices.find_all_by_customer_id(id).map do |invoice|
      @merchants.find_by_id(invoice.merchant_id)
    end.uniq{|merchant| merchant.id}
  end

  def sum_all_items_and_quanities(id)
    @invoice_items.find_all_by_invoice_id(id).map do |invoice_item|
      [invoice_item.unit_price, invoice_item.quantity]
    end.map do |array|
      array[0] * array[1]
    end.reduce(:+)
  end

end
