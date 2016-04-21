require 'pry'
require 'csv'

class Merchant

attr_reader :id, :name

  def initialize(merchant_hash, merchant_repository_object)
    @merchant_repository_object = merchant_repository_object
    merchant_hash = merchant_hash
    @id = merchant_hash[:id].to_i
    @name = merchant_hash[:name]
  end

  def items
    @merchant_repository_object.sales_engine_object.items.find_all_by_merchant_id(id)
  end

  def invoices
    @merchant_repository_object.sales_engine_object.invoices.find_all_by_merchant_id(id)
  end

end
