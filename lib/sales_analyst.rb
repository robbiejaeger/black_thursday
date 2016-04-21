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
    end.reduce(:+)/(@sales_engine.merchants.all.count.to_f-1)).round(2)
  end

  def merchants_with_high_item_count
    avg = average_items_per_merchant
    stdev = average_items_per_merchant_standard_deviation
    @sales_engine.merchants.all.find_all do |merchant|
      merchant.items.count > (avg + stdev)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @sales_engine.merchants.find_by_id(merchant_id)
    item_count = 0
    (merchant.items.map do |item|
      item_count += 1
      item.unit_price
    end.reduce(:+)/item_count).round(2)
  end

  def average_average_price_per_merchant
    (@sales_engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.reduce(:+)/@sales_engine.merchants.all.count).round(2)
  end

  def golden_items
    stdev = item_price_standard_deviation
    avg = average_item_price
    @sales_engine.items.all.find_all {|item| item.unit_price > (avg + 2*stdev)}
  end

  def item_price_standard_deviation
    avg = average_item_price
    Math.sqrt(@sales_engine.items.all.map do |item|
      (item.unit_price - avg) ** 2
    end.reduce(:+)/(@sales_engine.items.all.count - 1))
  end

  def average_item_price
    @sales_engine.items.all.map do |item|
      item.unit_price
    end.reduce(:+)/@sales_engine.items.all.count
  end

  def average_invoices_per_merchant
    (@sales_engine.invoices.all.count.to_f / @sales_engine.merchants.all.count).round(2)
  end

end
