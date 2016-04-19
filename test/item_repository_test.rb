require "minitest/autorun"
require "minitest/pride"
require "./lib/item_repository"

class ItemRepositoryTest < Minitest::Test

  def test_item_repository_can_exist
    csv_filepath = "./data/items_small.csv"
    ir = ItemRepository.new(csv_filepath)

    assert ir
  end

  def test_it_can_parse_a_small_csv_file
    csv_filepath = "./data/items_small.csv"
    ir = ItemRepository.new(csv_filepath)

    assert ir.all.kind_of?(Array)
  end

  def test_it_can_return_array_of_item_objects
    csv_filepath = "./data/items_small.csv"
    ir = ItemRepository.new(csv_filepath)

    assert ir.all[0].kind_of?(Item)
  end

  def test_can_find_an_item_by_id
    csv_filepath = "./data/items_small.csv"
    ir = ItemRepository.new(csv_filepath)

    item = ir.find_by_id(263403749)

    assert_equal 263403749, item.id
  end

  

end
