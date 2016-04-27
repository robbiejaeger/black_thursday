require_relative "./test_helper"
require "bigdecimal"
require "bigdecimal/util"
require "time"
require_relative "../lib/item"
require_relative "../lib/item_repository"
require_relative "../lib/sales_engine"

class ItemTest < Minitest::Test

  def setup
    csv_filepath = "./data/items.csv"
    @ir = ItemRepository.new(csv_filepath, nil)
  end

  def test_item_properties_and_values
    item = Item.new({
          :id => "1",
          :name        => "Pencil",
          :description => "Description",
          :unit_price  => "1099",
          :merchant_id => "3",
          :created_at  => "2016-01-11 11:30:36 UTC",
          :updated_at  => "1998-09-11 21:34:04 UTC"
        }, nil)

    assert item.kind_of?(Item)

    assert item.id.kind_of?(Fixnum)
    assert_equal 1, item.id

    assert item.name.kind_of?(String)
    assert_equal "Pencil", item.name

    assert item.description.kind_of?(String)
    assert_equal "Description", item.description

    assert item.unit_price.kind_of?(BigDecimal)
    assert_equal BigDecimal.new(10.99,4), item.unit_price

    assert item.merchant_id.kind_of?(Fixnum)
    assert_equal 3, item.merchant_id

    assert item.created_at.kind_of?(Time)
    assert_equal Time.parse("2016-01-11 11:30:36 UTC"), item.created_at

    assert item.updated_at.kind_of?(Time)
    assert_equal Time.parse("1998-09-11 21:34:04 UTC"), item.updated_at
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
