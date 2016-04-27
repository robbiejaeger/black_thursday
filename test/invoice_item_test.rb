require_relative "./test_helper"
require "time"
require "bigdecimal"
require "bigdecimal/util"
require_relative "../lib/invoice_item_repository"
require_relative "../lib/invoice_item"

class InvoiceItemTest < Minitest::Test

  def setup
    @ii = InvoiceItem.new({
      :id => "1",
      :item_id => "263519844",
      :invoice_id => "1",
      :quantity => "5",
      :unit_price => "13635",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
      }, nil)
  end

  def test_has_attributes_and_value
    assert @ii.kind_of?(InvoiceItem)

    assert @ii.id.kind_of?(Fixnum)
    assert_equal 1, @ii.id

    assert @ii.item_id.kind_of?(Fixnum)
    assert_equal 263519844, @ii.item_id

    assert @ii.invoice_id.kind_of?(Fixnum)
    assert_equal 1, @ii.invoice_id

    assert @ii.quantity.kind_of?(Fixnum)
    assert_equal 5, @ii.quantity

    assert @ii.unit_price.kind_of?(BigDecimal)
    assert_equal BigDecimal.new("13635",5)/100, @ii.unit_price

    assert @ii.created_at.kind_of?(Time)
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @ii.created_at

    assert @ii.updated_at.kind_of?(Time)
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @ii.updated_at
  end

  def test_can_convert_price_to_dollars
    assert @ii.unit_price_to_dollars.kind_of?(Float)
  end

end
