require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/invoice_repository"
require_relative "../lib/invoice"


class InvoiceRepositoryTest < Minitest::Test

  def setup
    csv_filepath = "./data/invoices.csv"
    @ir = InvoiceRepository.new(csv_filepath, nil)
  end

  def test_all

    assert_equal 4985, @ir.all.count
  end

  def test_find_by_id

    assert_equal 793, @ir.find_by_id(4000).customer_id
  end



end
