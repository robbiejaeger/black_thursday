require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/customer"
require_relative "../lib/customer_repository"

class CustomerTest < Minitest::Test

  def setup
    csv_filepath = "./data/invoices.csv"
    @cr = CustomerRepository.new(csv_filepath, nil)
  end

  def test_customer_id_is_an_integer
    customer1 = @cr.all[0]

    assert customer1.id.kind_of?(Fixnum)
  end


end
