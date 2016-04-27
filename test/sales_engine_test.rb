require_relative "./test_helper"
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_from_csv_creates_SE_object
    se = SalesEngine.from_csv({:items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })

    assert se.kind_of?(SalesEngine)
  end

  def test_engine_has_an_item_repo
    se = SalesEngine.from_csv({:items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })

    assert se.items.kind_of?(ItemRepository)
  end

  def test_engine_has_an_merchant_repo
    se = SalesEngine.from_csv({:items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })

    assert se.merchants.kind_of?(MerchantRepository)
  end

end
