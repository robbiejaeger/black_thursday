require_relative "./test_helper"
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_from_csv_creates_SE_object
    se = SalesEngine.from_csv({:items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })

    assert se
  end

end
