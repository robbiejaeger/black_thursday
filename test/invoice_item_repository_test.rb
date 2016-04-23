require "minitest/autorun"
require "minitest/pride"
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

end
