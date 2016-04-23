require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/invoice_item_repository"
require_relative "../lib/invoice_item"

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    csv_filepath = "./data/invoice_items.csv"
    @itr = InvoiceItemRepository.new(csv_filepath, nil)
    @invoice_item = @itr.all[0]
  end

  def test_invoice_item_exists
    assert @invoice_item.kind_of?(InvoiceItem)
  end

  def test_has_attributes_and_types
    assert @invoice_item.id.kind_of?(Fixnum)
    assert @invoice_item.item_id.kind_of?(Fixnum)
    assert @invoice_item.invoice_id.kind_of?(Fixnum)
    assert @invoice_item.quantity.kind_of?(Fixnum)
    assert @invoice_item.unit_price.kind_of?(BigDecimal)
    assert @invoice_item.created_at.kind_of?(Time)
    assert @invoice_item.updated_at.kind_of?(Time)
  end

  def test_can_convert_price_to_dollars
    assert @invoice_item.unit_price_to_dollars.kind_of?(Float)
  end

end
