require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/invoice_item_repository"
require_relative "../lib/invoice_item"

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    csv_filepath = "./data/invoice_items.csv"
    @itr = InvoiceItemRepository.new(csv_filepath, nil)
    @itr.all[0]
  end

  def test
    
  end

end
