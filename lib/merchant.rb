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
    @merchant_repository_object.find_items_by_merchant_id(self.id)
  end

  def invoices
    @merchant_repository_object.find_all_invoices_by_merchant_id(self.id)
  end

end
