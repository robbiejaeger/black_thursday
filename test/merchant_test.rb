require "minitest/autorun"
require "minitest/pride"
require "pry"
require_relative "../lib/merchant"
require_relative "../lib/sales_engine"


class MerchantsTest < Minitest::Test

  def test_creates_mechant
    merch = Merchant.new({:id => 555, :name => "Turing School"}, nil)
    assert merch.kind_of?(Merchant)
  end

  def test_can_get_item_object_from_merchant_id
    se = SalesEngine.from_csv({
      :items     => "./data/items_small.csv",
      :invoices  => "./data/invoices.csv",
      :merchants => "./data/merchants.csv",
    })

    merchant = se.merchants.find_by_id(12334105)
    items = merchant.items

    assert items[0].is_a?(Item)
  end

  def test_can_get_invoice_object_from_merchant_id
    se = SalesEngine.from_csv({
      :items     => "./data/items_small.csv",
      :invoices  => "./data/invoices.csv",
      :merchants => "./data/merchants.csv",
    })

    merchant = se.merchants.find_by_id(12334105)
    invoices = merchant.invoices

    assert_equal 10, invoices.count
    end

end
