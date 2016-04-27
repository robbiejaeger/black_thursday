require_relative "./test_helper"
require "time"
require_relative "../lib/customer"
require_relative "../lib/customer_repository"

class CustomerTest < Minitest::Test

  def test_customer_properties_and_values
    @c = Customer.new({
      :id => "1",
      :first_name => "Joey",
      :last_name => "Ondricka",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
      }, nil)

    assert @c.id.kind_of?(Fixnum)
    assert_equal 1, @c.id

    assert @c.first_name.kind_of?(String)
    assert_equal "Joey", @c.first_name

    assert @c.last_name.kind_of?(String)
    assert_equal "Ondricka", @c.last_name

    assert @c.created_at.kind_of?(Time)
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @c.created_at

    assert @c.updated_at.kind_of?(Time)
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @c.updated_at
  end


end
