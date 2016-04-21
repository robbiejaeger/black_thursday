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
    refute @ir.find_by_id(46666000)
    assert_equal 793, @ir.find_by_id(4000).customer_id
  end

  def test_find_all_by_customer_id
    assert_equal [], @ir.find_all_by_customer_id(5555)
    assert_equal 8, @ir.find_all_by_customer_id(1).count
  end

  def test_find_all_by_merchant_id
    assert_equal [], @ir.find_all_by_merchant_id(2139875)
    assert_equal 16 ,@ir.find_all_by_merchant_id(12335938).count 
  end

end
