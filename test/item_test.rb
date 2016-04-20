require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/item"
require_relative "../lib/item_repository"
require_relative "../lib/sales_engine"

class ItemTest < Minitest::Test

  def setup
    csv_filepath = "./data/items.csv"
    @ir = ItemRepository.new(csv_filepath, nil)
  end

  def test_item_id_is_an_integer
    item1 = @ir.all[0]

    assert item1.id.kind_of?(Fixnum)
  end

  def test_merchant_id_is_an_integer
    item1 = @ir.all[0]

    assert item1.merchant_id.kind_of?(Fixnum)
  end

  def test_created_at_is_a_time_object
    item1 = @ir.all[0]

    assert item1.created_at.kind_of?(Time)
  end

  def test_updated_at_is_a_time_object
    item1 = @ir.all[0]

    assert item1.updated_at.kind_of?(Time)
  end

  def test_unit_price_is_bigdecimal_class
    item1 = @ir.all[0]

    assert item1.unit_price.kind_of?(BigDecimal)
  end

  def test_unit_price_to_dollars_is_float
    dollars_price = @ir.all[0].unit_price_to_dollars

    assert dollars_price.kind_of?(Float)
  end

  def test_can_get_item_object_from_merchant_id
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    item = se.items.find_by_id(263396209)
    merchant = item.merchant

    assert merchant.kind_of?(Merchant)
  end

end
