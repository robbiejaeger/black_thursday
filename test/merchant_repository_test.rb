require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/merchant_repository"


class MerchantsRepositoryTest < Minitest::Test

  def setup
    @merch = MerchantRepository.new('./data/merchants.csv', nil)
  end

  def test_all_returns_array_of_all_known_merchants
    assert @merch.all[0].kind_of?(Merchant)
    assert @merch.all.kind_of?(Array)
  end

  def test_find_by_id_returns_merchant_object
    assert @merch.find_by_id(12334144).kind_of?(Merchant)
    assert @merch.find_by_id(92334145).nil?
  end

  def test_find_by_id_returns_nil_for_invalid_id
    merchant = @merch.find_by_id(1)

    assert_equal nil, merchant
  end

  def test_find_by_name_returns_merchant_object
    assert @merch.find_by_name("BowlsByChris").kind_of?(Merchant)
    assert @merch.find_by_name("BowlsByChrist").nil?
  end

  def test_find_by_name_returns_nil_for_invalid_name
    merchant = @merch.find_by_name("kajshd")

    assert_equal nil, merchant
  end

  def test_find_all_by_name_returns_all_objects_with_name
    assert @merch.find_all_by_name("Nic").kind_of?(Object)
    assert_equal 8, @merch.find_all_by_name("Nic").count
  end

  def test_find_all_by_name_returns_empty_array_for_invalid_string
    merchants = @merch.find_all_by_name("ajksdkjhas")

    assert_equal [], merchants
  end

end
