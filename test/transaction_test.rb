require "minitest/autorun"
require "minitest/pride"
require "time"
require_relative "../lib/transaction"

class TransactionTest < Minitest::Test

  def setup
    @t = Transaction.new({
      :id => "1",
      :invoice_id => "2179",
      :credit_card_number => "4068631943231470",
      :credit_card_expiration_date => "217",
      :result => "success",
      :created_at => "2012-02-26 20:56:56 UTC",
      :updated_at => "2012-02-26 20:56:56 UTC"
      }, nil)
  end

  def test_transaction_properties_and_types
    assert @t.id.kind_of?(Fixnum)
    assert_equal 1, @t.id

    assert @t.invoice_id.kind_of?(Fixnum)
    assert_equal 2179, @t.invoice_id

    assert @t.credit_card_number.kind_of?(Fixnum)
    assert_equal 4068631943231470, @t.credit_card_number

    assert @t.result.kind_of?(String)
    assert_equal "success", @t.result

    assert @t.created_at.kind_of?(Time)
    assert_equal Time.parse("2012-02-26 20:56:56 UTC"), @t.created_at

    assert @t.updated_at.kind_of?(Time)
    assert_equal Time.parse("2012-02-26 20:56:56 UTC"), @t.updated_at
  end

end
