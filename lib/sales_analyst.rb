class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (@sales_engine.items.all.count.to_f/@sales_engine.merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    Math.sqrt(@sales_engine.merchants.all.map do |merchant|
      (merchant.items.count - avg) ** 2
    end.reduce(:+)/@sales_engine.merchants.all.count.to_f).round(2)
  end

  def merchants_with_high_item_count
    stdev = average_items_per_merchant_standard_deviation
    @sales_engine.merchants.all.find_all do |merchant|
      merchant.items.count > (1 + stdev)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @sales_engine.merchants.find_by_id(merchant_id)
    item_count = 0
    merchant.items.map do |item|
      item_count += 1
      item.unit_price
    end.reduce(:+)/item_count
  end

end
