require_relative "./test_helper"
require_relative "../lib/sales_analyst"
require_relative "../lib/sales_engine"

class SalesAnalystTest < Minitest::Test

  def test_it_can_exist
    se = SalesEngine.from_csv({:items => "./data/items.csv"})

    sa = SalesAnalyst.new(se)

    assert sa
  end

  def test_can_average_items_per_merchant
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })

    sa = SalesAnalyst.new(se)

    avg = sa.average_items_per_merchant

    assert_equal 2.88, avg
  end

  def test_can_get_standard_deviation
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })

    sa = SalesAnalyst.new(se)

    stdev = sa.average_items_per_merchant_standard_deviation

    assert_equal 3.26, stdev
  end

  def test_can_get_merchants_with_high_item_count
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })

    sa = SalesAnalyst.new(se)

    merchs = sa.merchants_with_high_item_count

    assert_equal 52, merchs.count
  end

  def test_can_find_average_item_price_for_merchant
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })

    sa = SalesAnalyst.new(se)

    avg_price = sa.average_item_price_for_merchant(12334105)

    assert avg_price.kind_of?(BigDecimal)
  end

  def test_can_find_average_of_average_price_per_merchant
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })

    sa = SalesAnalyst.new(se)

    avg_avg_price = sa.average_average_price_per_merchant

    assert avg_avg_price.kind_of?(BigDecimal)
  end

  def test_can_find_average_price_of_all_items
    se = SalesEngine.from_csv({:items => "./data/items.csv"})

    sa = SalesAnalyst.new(se)

    avg_item_price = sa.average_item_price

    assert avg_item_price.kind_of?(BigDecimal)
  end

  def test_can_get_stdev_of_item_price
    se = SalesEngine.from_csv({:items => "./data/items.csv"})

    sa = SalesAnalyst.new(se)

    stdev_item_price = sa.item_price_standard_deviation

    assert stdev_item_price.kind_of?(Float)
  end

  def test_can_get_golden_items
    se = SalesEngine.from_csv({:items => "./data/items.csv",})

    sa = SalesAnalyst.new(se)

    golden_items = sa.golden_items

    assert_equal 5, golden_items.count
  end

  def test_can_get_avg_invoices_per_merchant
    se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
      })

    sa = SalesAnalyst.new(se)

    assert_equal 10.49, sa.average_invoices_per_merchant
  end

  def test_can_get_average_invoices_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
      })

    sa = SalesAnalyst.new(se)

    assert_equal  3.29, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_can_get_top_merchants_by_invoice_count
    se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
      })

    sa = SalesAnalyst.new(se)

    assert_equal 12, sa.top_merchants_by_invoice_count.count
  end

  def test_can_get_bottom_merchants_by_invoice_count
    se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })

    sa = SalesAnalyst.new(se)

    assert 12, sa.bottom_merchants_by_invoice_count.count
  end

  def test_can_get_top_days_by_invoice_count
    se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal ["Wednesday"], sa.top_days_by_invoice_count
  end

  def test_can_get_invoice_status_percentages
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})

    sa = SalesAnalyst.new(se)

    assert_equal 56.95, sa.invoice_status(:shipped)
  end

  def test_can_get_invoice_revenue_for_certain_date
    se = SalesEngine.from_csv({
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 0, sa.total_revenue_by_date(Time.parse("2009-02-07"))
  end

  def test_total_invoices_pending
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})

    sa = SalesAnalyst.new(se)

    assert_equal 1473, sa.total_invoices_pending
  end

  def test_total_invoices_returned
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})

    sa = SalesAnalyst.new(se)

    assert_equal 673, sa.total_invoices_returned
  end

  def test_merchants_with_only_one_item
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    sa = SalesAnalyst.new(se)

    assert sa.merchants_with_only_one_item[0].kind_of?(Merchant)
  end

  def test_merchants_ranked_by_revenue
    se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
    })

    sa = SalesAnalyst.new(se)

    assert sa.merchants_ranked_by_revenue[1].kind_of?(Merchant)
  end

  def test_invoice_status
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})

    sa = SalesAnalyst.new(se)

    assert_equal 29.55, sa.invoice_status(:pending)
    assert_equal 56.95, sa.invoice_status(:shipped)
    assert_equal 13.50, sa.invoice_status(:returned)
  end

end
