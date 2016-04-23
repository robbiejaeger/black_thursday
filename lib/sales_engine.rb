require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items

  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self)
    @invoices = InvoiceRepository.new(hash[:invoices], self)
    @merchants = MerchantRepository.new(hash[:merchants], self)
    @invoice_items = InvoiceItemRepository.new(hash[:invoice_items], self)
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

end
