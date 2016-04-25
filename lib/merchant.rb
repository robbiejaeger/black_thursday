require 'time'


class Merchant

attr_reader :id, :name, :created_at

  def initialize(merchant_hash, merchant_repository_object)
    @merchant_repository_object = merchant_repository_object
    @id = merchant_hash[:id].to_i
    @name = merchant_hash[:name]
    @created_at = Time.parse(merchant_hash[:created_at])
  end

  def items
    @merchant_repository_object.find_items_by_merchant_id(self.id)
  end

  def invoices
    @merchant_repository_object.find_all_invoices_by_merchant_id(self.id)
  end

  def customers
    @merchant_repository_object.find_all_customers_for_merchant(self.id)
  end

end
