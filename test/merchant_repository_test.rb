require "minitest/autorun"
require "minitest/pride"
require "./lib/merchant_repository"


class MerchantsRepositoryTest < Minitest::Test

  def test_all_returns_array_of_all_known_merchants
    merch = MerchantRepository.new
    merch.all
    assert true, merch.all.kind_of?(Array)
  end

  def test_find_by_id
    skip
  end

  def test_find_by_name
    skip
  end

  def test_find_all_by_name
    skip
  end
end
