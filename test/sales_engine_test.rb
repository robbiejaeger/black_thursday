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
    se = SalesEngine.from_csv({:items => "./data/items.csv"})

    assert se.items.kind_of?(ItemRepository)
  end

  def test_engine_has_an_merchant_repo
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv"})

    assert se.merchants.kind_of?(MerchantRepository)
  end

  def test_engine_has_invoice_repo
    se = SalesEngine.from_csv({:invoice_items => "./data/invoice_items.csv"})

    assert se.invoices.kind_of?(InvoiceRepository)
  end

  def test_engine_has_customer_repo
    se = SalesEngine.from_csv({:customers => "./data/customers.csv"})

    assert se.customers.kind_of?(CustomerRepository)
  end

  def test_engine_has_invoice_item_repo
    se = SalesEngine.from_csv({:invoice_items => "./data/invoice_items.csv"})

    assert se.invoice_items.kind_of?(InvoiceItemRepository)
  end

  def test_engine_has_transaction_repo
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv"})

    assert se.transactions.kind_of?(TransactionRepository)
  end

end
