require "minitest/autorun"
require "minitest/pride"
require "./lib/merchant_repository"
require "pry"


class MerchantsRepositoryTest < Minitest::Test

  def test_all_returns_array_of_all_known_merchants
    merch = MerchantRepository.new('./data/merchants.csv')
    assert merch.all[0].kind_of?(Merchant)
    assert merch.all.kind_of?(Array)
  end

  def test_find_by_id_returns_object
    merch = MerchantRepository.new('./data/merchants.csv')
    assert merch.find_by_id(12334144).kind_of?(Object)
    assert merch.find_by_id(92334145).nil?
  end

  def test_find_by_name_returns_object
    merch = MerchantRepository.new('./data/merchants.csv')
    assert merch.find_by_name("BowlsByChris").kind_of?(Object)
    assert merch.find_by_name("BowlsByChrist").nil?
  end

  def test_find_all_by_name
    skip
  end
end
