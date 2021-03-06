require_relative "./test_helper"
require_relative "../lib/item_repository"

class ItemRepositoryTest < Minitest::Test

  def setup
    csv_filepath = "./data/items.csv"
    @ir = ItemRepository.new(csv_filepath, nil)
  end

  def test_item_repository_can_exist
    assert @ir
  end

  def test_it_can_parse_a_small_csv_file
    assert @ir.all.kind_of?(Array)
  end

  def test_it_can_return_array_of_item_objects
    assert @ir.all[0].kind_of?(Item)
  end

  def test_can_find_an_item_by_id
    item = @ir.find_by_id(263403749)

    assert_equal 263403749, item.id
  end

  def test_find_by_id_returns_nil_for_no_such_id
    item = @ir.find_by_id(2)

    assert_equal nil, item
  end

  def test_can_find_item_by_name
    item = @ir.find_by_name("510+ RealPush Icon Set")

    assert_equal "510+ RealPush Icon Set", item.name
  end

  def test_returns_nil_for_item_by_name_with_no_such_name
    item = @ir.find_by_name("asdasdadasd")

    assert_equal nil, item
  end

  def test_find_by_name_is_case_insensitive
    item = @ir.find_by_name("510+ realpush icon Set")

    assert_equal "510+ RealPush Icon Set", item.name
  end

  def test_can_find_items_by_description_string
    items = @ir.find_all_with_description("two")

    assert_equal 69, items.count
  end

  def test_find_by_description_returns_empty_array_for_bad_description
    items = @ir.find_all_with_description("kjashdkjahskdh")

    assert items.kind_of?(Array)
    assert_equal 0, items.count
  end

  def test_find_all_by_merchant_id_can_find_merchants
    items = @ir.find_all_by_merchant_id(12334185)

    assert items.kind_of?(Array)
    assert items[0].kind_of?(Item)
    assert_equal 6, items.count
  end

  def test_find_by_merchant_id_returns_empty_array_for_bad_id
    items = @ir.find_all_by_merchant_id(5)

    assert_equal [], items
  end

  def test_can_find_all_items_by_price
    items = @ir.find_all_by_price(500)

    assert items[0].kind_of?(Item)
    assert_equal 11, items.count
  end

  def test_returns_empty_array_for_no_items_with_a_price
    items = @ir.find_all_by_price(0.0001)

    assert_equal [], items
  end

  def test_can_find_items_in_price_range
    items = @ir.find_all_by_price_in_range((500..5000))

    assert items[0].kind_of?(Item)
    assert_equal 89, items.count
  end

end
