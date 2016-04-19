require "minitest/autorun"
require "minitest/pride"
require "pry"
require_relative "../lib/merchant"

class MerchantsTest < Minitest::Test

  def test_creates_mechant
    merch = Merchant.new(:id => 555, :name => "Turing School")
    assert merch.kind_of?(Merchant)
  end
  
end
