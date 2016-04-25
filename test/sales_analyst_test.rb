require "minitest/autorun"
require "minitest/pride"
require "pry"
require_relative "../lib/sales_analyst"
require_relative "../lib/sales_engine"

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })

    @sa = SalesAnalyst.new(se)
  end
  #
  # def test_it_can_exist
  #   assert @sa
  # end
  #
  # def test_can_average_items_per_merchant
  #   avg = @sa.average_items_per_merchant
  #
  #   assert_equal 2.88, avg
  # end
  #
  # def test_can_get_standard_deviation
  #   stdev = @sa.average_items_per_merchant_standard_deviation
  #
  #   assert_equal 3.26, stdev
  # end
  #
  # def test_can_get_merchants_with_high_item_count
  #   merchs = @sa.merchants_with_high_item_count
  #
  #   assert_equal 52, merchs.count
  # end
  #
  # def test_can_find_average_item_price_for_merchant
  #   avg_price = @sa.average_item_price_for_merchant(12334105)
  #
  #   assert avg_price.kind_of?(BigDecimal)
  # end
  #
  # def test_can_find_average_of_average_price_per_merchant
  #   avg_avg_price = @sa.average_average_price_per_merchant
  #
  #   assert avg_avg_price.kind_of?(BigDecimal)
  # end
  #
  # def test_can_find_average_price_of_all_items
  #   avg_item_price = @sa.average_item_price
  #
  #   assert avg_item_price.kind_of?(BigDecimal)
  # end
  #
  # def test_can_get_stdev_of_item_price
  #   stdev_item_price = @sa.item_price_standard_deviation
  #
  #   assert stdev_item_price.kind_of?(Float)
  # end
  #
  # def test_can_get_golden_items
  #   golden_items = @sa.golden_items
  #
  #   assert_equal 5, golden_items.count
  # end
  #
  # def test_can_get_avg_invoices_per_merchant
  #   assert_equal 10.49, @sa.average_invoices_per_merchant
  # end
  #
  # def test_can_get_average_invoices_per_merchant_standard_deviation
  #   assert_equal  3.29, @sa.average_invoices_per_merchant_standard_deviation
  # end
  #
  # def test_can_get_top_merchants_by_invoice_count
  #   assert (Array), @sa.top_merchants_by_invoice_count
  # end
  #
  # def test_can_get_bottom_merchants_by_invoice_count
  #   assert (Array), @sa.bottom_merchants_by_invoice_count
  # end
  #
  # def test_can_get_top_days_by_invoice_count
  #   assert_equal ["Wednesday"], @sa.top_days_by_invoice_count
  # end
  #
  # def test_can_get_invoice_status_percentages
  #   assert_equal 56.95, @sa.invoice_status(:shipped)
  # end
  #
  # def test_can_get_invoices_for_certain_date
  #   @sa.total_revenue_by_date(Time.parse("2009-02-07")).kind_of?(Array)
  # end
  #
  def test_can_get_merchants_with_pending_invoices
    @sa.merchants_with_pending_invoices
  end
end
