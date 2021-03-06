require_relative "./test_helper"
require "time"
require_relative "../lib/merchant"
require_relative "../lib/sales_engine"


class MerchantsTest < Minitest::Test

  def test_creates_mechant
    merch = Merchant.new({
      :id => "555",
      :name => "Turing School",
      :created_at => "2010-12-10"
      }, nil)

    assert merch.kind_of?(Merchant)
  end

  def test_properties_and_values
    merch = Merchant.new({
      :id => "555",
      :name => "Turing School",
      :created_at => "2010-12-10"
      }, nil)

    assert merch.id.kind_of?(Fixnum)
    assert_equal 555, merch.id

    assert merch.name.kind_of?(String)
    assert_equal "Turing School", merch.name

    assert merch.created_at.kind_of?(Time)
    assert_equal Time.parse("2010-12-10"), merch.created_at
  end

  def test_can_get_item_object_from_merchant_id
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices  => "./data/invoices.csv",
      :merchants => "./data/merchants.csv",
    })

    merchant = se.merchants.find_by_id(12334105)
    items = merchant.items

    assert items[0].is_a?(Item)
  end

  def test_can_get_invoice_object_from_merchant_id
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices  => "./data/invoices.csv",
      :merchants => "./data/merchants.csv",
    })

    merchant = se.merchants.find_by_id(12334105)
    invoices = merchant.invoices

    assert_equal 10, invoices.count
  end

end
