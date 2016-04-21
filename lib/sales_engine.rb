require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'

class SalesEngine
  attr_reader :items, :merchants, :invoices

  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self)
    @invoices = InvoiceRepository.new(hash[:invoices], self)
    @merchants = MerchantRepository.new(hash[:merchants], self)
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end
end
