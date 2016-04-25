require 'time'
require 'pry'

class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (@sales_engine.items.all.count.to_f/@sales_engine.merchants.all.count.to_f).round(2)
  end

  def standard_deviation(set, avg)
    Math.sqrt(set.map do |set_item|
      (set_item - avg) ** 2
    end.reduce(:+)/(set.count.to_f-1)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    set = @sales_engine.merchants.all.map do |merchant|
      merchant.items.count
    end
    standard_deviation(set, average_items_per_merchant)
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
    set = @sales_engine.items.all.map do |item|
      item.unit_price
    end
    standard_deviation(set, average_item_price)
  end

  def average_item_price
    @sales_engine.items.all.map do |item|
      item.unit_price
    end.reduce(:+)/@sales_engine.items.all.count
  end

  def average_invoices_per_merchant
    (@sales_engine.invoices.all.count.to_f / @sales_engine.merchants.all.count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    set = @sales_engine.merchants.all.map do |merchant|
      merchant.invoices.count
    end
    standard_deviation(set, average_invoices_per_merchant)
  end

  def top_merchants_by_invoice_count
    avg = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    @sales_engine.merchants.all.find_all do |merchant|
      merchant.invoices.count > 2 * std_dev + avg
    end
  end

  def bottom_merchants_by_invoice_count
    avg = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    @sales_engine.merchants.all.find_all do |merchant|
      merchant.invoices.count < avg - 2 * std_dev
    end
  end

  def set_of_invoices_by_day
    set_of_invoices_by_day = Hash.new(0)
    @sales_engine.invoices.all.each do |invoice|
        set_of_invoices_by_day[invoice.created_at.strftime("%A")] += 1
    end
    set_of_invoices_by_day
  end

  def avg_invoices_per_day
    set_of_invoices_by_day.values.reduce(:+)/7
  end

  def standard_deviation_invoices_per_day
    set = set_of_invoices_by_day.values
    standard_deviation(set, avg_invoices_per_day)
  end

  def top_days_by_invoice_count
    std_dev = standard_deviation_invoices_per_day
    avg = avg_invoices_per_day
    set_of_invoices_by_day.select do |day, num|
      num > (std_dev + avg)
    end.map {|array| array[0] }
  end

  def total_invoices_shipped
    @sales_engine.invoices.all.count {|invoice| invoice.status == :shipped}
  end

  def total_invoices_pending
    @sales_engine.invoices.all.count {|invoice| invoice.status == :pending}
  end

  def total_invoices_returned
    @sales_engine.invoices.all.count {|invoice| invoice.status == :returned}
  end

  def invoice_status(status)
    total_invoices = @sales_engine.invoices.all.count
    if status == :pending
      (total_invoices_pending.to_f/total_invoices*100).round(2)
    elsif status == :shipped
      (total_invoices_shipped.to_f/total_invoices*100).round(2)
    elsif status == :returned
      (total_invoices_returned.to_f/total_invoices*100).round(2)
    end
  end

  def total_revenue_by_date(date)
    invoices = @sales_engine.invoices.all.find_all {|invoice| invoice.created_at.strftime("%Y-%m-%d") == date.strftime("%Y-%m-%d")}
    invoices.map do |invoice|
      invoice.total
    end.reduce(:+)
  end

  def top_revenue_earners(x = 20)
    all_merchants = @sales_engine.merchants.all

    merchant_invoices = @sales_engine.merchants.all.map do |merchant|
      merchant.invoices
    end

    merchant_revenue = merchant_invoices.map do |invoices|
      invoices.map do |invoice|
        invoice.total
      end.reduce(:+)
    end

    merchant_revenue_in_order = all_merchants.zip(merchant_revenue).sort_by{|a| -a[1]}[0...x]
    merchant_revenue_in_order.map do |array|
      array[0]
    end
  end

  def merchants_with_pending_invoices
    all_invoices = @sales_engine.invoices.all
    result = all_invoices.find_all { |invoice| invoice.is_paid_in_full? == false }
    result.map { |invoice| invoice.merchant }.uniq
  end

  def merchants_with_only_one_item
    all_merchants = @sales_engine.merchants.all
    all_merchants.find_all { |merchant| merchant.items.count == 1 }
  end

  def merchants_with_only_one_item_registered_in_month(month)
    months = Date::MONTHNAMES
    month_number = months.index(month.capitalize)

    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at.month == month_number
    end
  end

  def revenue_by_merchant(merchant_id)
    invoices = @sales_engine.merchants.find_all_invoices_by_merchant_id(merchant_id)
    invoices.map { |invoice| invoice.total }.reduce(:+)
  end

  def most_sold_item_for_merchant(merchant_id)

  end

end
