require "time"
require "bigdecimal"
require "bigdecimal/util"

class Item

  attr_reader :id, :name, :description, :unit_price,
              :merchant_id, :created_at, :updated_at

  def initialize(item_hash, item_repository_object)
    @item_repository_object = item_repository_object
    @id = item_hash[:id].to_i
    @name = item_hash[:name]
    @description = item_hash[:description]
    @unit_price = BigDecimal.new(item_hash[:unit_price],
                  item_hash[:unit_price].length)/100
    @merchant_id = item_hash[:merchant_id].to_i
    @created_at = Time.parse(item_hash[:created_at])
    @updated_at = Time.parse(item_hash[:updated_at])
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def merchant
    @item_repository_object.find_merchant_by_merchant_id(self.merchant_id)
  end

end
