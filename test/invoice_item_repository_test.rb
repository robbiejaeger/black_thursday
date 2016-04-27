require_relative "./test_helper"
require_relative "../lib/invoice_item_repository"

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    csv_filepath = "./data/invoice_items.csv"
    @itr = InvoiceItemRepository.new(csv_filepath, nil)
  end

  def test_can_exist_and_is_item_repo_class
    assert @itr
    assert @itr.kind_of?(InvoiceItemRepository)
  end

  def test_repository_has_invoice_items
    assert @itr.all[0].kind_of?(InvoiceItem)
  end

  def test_can_find_invoice_item_by_id
    assert_equal 1, @itr.find_by_id(1).id
  end

  def test_can_find_invoice_item_by_item_id
    assert_equal 164, @itr.find_all_by_item_id(263519844).count
  end

  def test_can_find_all_by_invoice_id
    assert_equal 4, @itr.find_all_by_invoice_id(2).count
  end

end
