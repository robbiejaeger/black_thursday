require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(hash)
    @items = ItemRepository.new(hash[:items])
    @merchants = MerchantRepository.new(hash[:merchants])
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end
end

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})

puts merchant = se.merchants.find_by_id(12334105)

merchant.items
