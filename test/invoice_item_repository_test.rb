require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/invoice_item_repository"

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    csv_filepath = "../data/invoice_items.csv"
    @itr = InvoiceItemRepository.new(csv_filepath, nil)
  end

  def test_can_exist
      
  end

end
