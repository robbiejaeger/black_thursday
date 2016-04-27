require_relative "./test_helper"
require_relative "../lib/transaction_repository"


class TransactionRepositoryTest < Minitest::Test

  def setup
    @trans = TransactionRepository.new('./data/transactions.csv', nil)
  end

  def test_all_returns_array_of_all_known_transactions
    assert @trans.all[0].kind_of?(Transaction)
    assert @trans.all.kind_of?(Array)
  end

  def test_find_by_id_returns_transaction_object
    assert @trans.find_by_id(1).kind_of?(Transaction)
    assert @trans.find_by_id(92334145).nil?
  end

  def test_find_all_by_invoice_id
    assert @trans.find_all_by_invoice_id(2179)[0].kind_of?(Transaction)
    assert_equal 2, @trans.find_all_by_invoice_id(2179).count
  end

  def test_find_all_by_credit_card_number
    assert @trans.find_all_by_credit_card_number(4068631943231470)[0].kind_of?(Transaction)
    assert_equal 1, @trans.find_all_by_credit_card_number(4068631943231470).count
  end

  def test_find_all_by_result
    assert @trans.find_all_by_result("success")[0].kind_of?(Transaction)
    assert_equal 4158, @trans.find_all_by_result("success").count
  end

end
