require_relative "./test_helper"
require_relative "../lib/customer_repository"
require_relative "../lib/customer"


class CustomerRepositoryTest < Minitest::Test

  def setup
    csv_filepath = "./data/customers.csv"
    @cr = CustomerRepository.new(csv_filepath, nil)
  end

  def test_all
    customers = @cr.all

    assert_equal 1000, customers.count
    assert customers[0].kind_of?(Customer)
  end

  def test_find_by_id
    assert_equal "Constance", @cr.find_by_id(22).first_name
  end

  def test_find_by_id_returns_nil_for_invalid_id
    customer = @cr.find_by_id(1001)

    assert_equal nil, customer
  end

  def test_find_all_by_first_name
    assert_equal 0, @cr.find_all_by_first_name("zabka").count
    assert_equal 2, @cr.find_all_by_first_name("Woodrow").count
  end

  def test_find_all_by_first_name_returns_empty_array_for_invalid_name
    customers = @cr.find_all_by_first_name("akjdakjshd")

    assert_equal [], customers
  end

  def test_find_all_by_last_name
    assert_equal 0, @cr.find_all_by_last_name("Aversano").count
    assert_equal 5, @cr.find_all_by_last_name("Wyman").count
  end

  def test_find_all_by_last_name_returns_empty_array_for_invalid_anem
    customers = @cr.find_all_by_last_name("akjdakjshd")

    assert_equal [], customers
  end

end
