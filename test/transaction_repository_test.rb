require "minitest/autorun"
require "minitest/pride"
require "pry"
require_relative "../lib/transaction_repository"


class TransactionRepositoryTest < Minitest::Test

  def test_all_returns_array_of_all_known_transactions
    trans = TransactionRepository.new('./data/transactions.csv', nil)
    assert trans.all[0].kind_of?(Transaction)
    assert trans.all.kind_of?(Array)
  end

  def test_find_by_id_returns_transaction_object
    trans = TransactionRepository.new('./data/transactions.csv', nil)
    assert trans.find_by_id(1).kind_of?(Transaction)
    assert trans.find_by_id(92334145).nil?
  end

  def test_find_all_by_invoice_id
    trans = TransactionRepository.new('./data/transactions.csv', nil)
    assert trans.find_all_by_invoice_id(2179)[0].kind_of?(Transaction)
    assert_equal 2, trans.find_all_by_invoice_id(2179).count
  end

  def test_find_all_by_credit_card_number
    trans = TransactionRepository.new('./data/transactions.csv', nil)
    assert trans.find_all_by_credit_card_number("4177816490204470")[0].kind_of?(Transaction)
    assert_equal 1, trans.find_all_by_credit_card_number("4177816490204470").count
  end

  def test_find_all_by_result
    trans = TransactionRepository.new('./data/transactions.csv', nil)
    assert trans.find_all_by_result("success")[0].kind_of?(Transaction)
    assert_equal 4158, trans.find_all_by_result("success").count
  end



end
