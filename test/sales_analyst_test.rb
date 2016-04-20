require "minitest/autorun"
require "minitest/pride"
require "pry"
require_relative "../lib/sales_analyst"
require_relative "../lib/sales_engine"

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    @sa = SalesAnalyst.new(se)
  end

  def test_it_can_exist
    assert @sa
  end

  def test_can_average_items_per_merchant
    avg = @sa.average_items_per_merchant

    assert_equal 2.88, avg
  end

  def test_can_get_standard_deviation
    stdev = @sa.average_items_per_merchant_standard_deviation

    assert_equal 3.26, stdev
  end

  def test_can_get_merchants_with_high_item_count
    merchs = @sa.merchants_with_high_item_count

    assert_equal 85, merchs.count
  end

  def test_can_find_average_item_price_for_merchant
    avg_price = @sa.average_item_price_for_merchant(12334105)

    assert avg_price.kind_of?(BigDecimal)
  end

  def test_can_find_average_of_average_price_per_merchant
    avg_avg_price = @sa.average_average_price_per_merchant

    assert avg_avg_price.kind_of?(BigDecimal)
  end

end
