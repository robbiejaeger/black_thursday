gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_from_csv_creates_SE_object
    se = SalesEngine.new
    assert se.items("./data/items.csv")
  end








end
