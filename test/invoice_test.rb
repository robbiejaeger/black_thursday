require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/invoice"
require_relative "../lib/invoice_repository"

class InvoiceTest < Minitest::Test

  def setup
    csv_filepath = "./data/invoices.csv"
    @ir = InvoiceRepository.new(csv_filepath, nil)
  end

  def test_invoice_id_is_an_integer
    invoice1 = @ir.all[0]

    assert invoice1.id.kind_of?(Fixnum)
  end



end
