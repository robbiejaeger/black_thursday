require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/customer_repository"
require_relative "../lib/customer"


class CustomerRepositoryTest < Minitest::Test

  def setup
    csv_filepath = "./data/customers.csv"
    @cr = CustomerRepository.new(csv_filepath, nil)
  end

  def test_all
    assert_equal 1000, @cr.all.count
  end

  def test_find_by_id
    assert_equal "Constance", @cr.find_by_id(22).first_name
  end

  def test_find_all_by_first_name
    assert_equal 0, @cr.find_all_by_first_name("zabka").count
    assert_equal 2, @cr.find_all_by_first_name("Woodrow").count
  end

  def test_find_all_by_last_name
    assert_equal 0, @cr.find_all_by_last_name("Aversano").count
    assert_equal 5, @cr.find_all_by_last_name("Wyman").count

  end


end
