# require_relative 'merchant_repository'
# require_relative 'item_repository'

class SalesEngine

  attr_reader :items, :merchants

  # def initialize(csv_file_path)
  #   @items = ItemRepository.new(csv_file_path[:items])
  #   @merchants = MerchantRepository.new(csv_file_path[:merchants])
  # end

  def self.from_csv(csv_file_path)
    @items = ItemRepository.new(csv_file_path[:items])
    @merchants = MerchantRepository.new(csv_file_path[:merchants])
    # SalesEngine.new(hash)
  #  {:items => "./data/items.csv",
  #  :merchants => "./data/merchants.csv"
  # }
    #SalesEngine.new ??
    # returns Hash
  end
  #figure out how the salesengine object
  #is created from the from_csv method




end
#
# se = SalesEngine.from_csv(({:items => "./data/items.csv",
#    :merchants => "./data/merchants.csv"
#   }))
#
# puts se.from_csv({:items => "./data/items.csv",
#    :merchants => "./data/merchants.csv"
#   })

se = SalesEngine.from_csv("./data/items.csv")
puts se
