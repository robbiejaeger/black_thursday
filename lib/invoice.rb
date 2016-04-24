require 'pry'
require "bigdecimal"
require "bigdecimal/util"
require "time"

class Invoice

  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

   def initialize(invoice_hash, invoice_repository_object)
     @invoice_repository_object = invoice_repository_object
     @id = invoice_hash[:id].to_i
     @customer_id = invoice_hash[:customer_id].to_i
     @merchant_id = invoice_hash[:merchant_id].to_i
     @status = invoice_hash[:status].to_sym
     @created_at = Time.parse(invoice_hash[:created_at])
     @updated_at = Time.parse(invoice_hash[:updated_at])
   end

   def merchant
     @invoice_repository_object.find_merchant_by_merchant_id(self.merchant_id)
   end

   def items
     @invoice_repository_object.find_invoice_items_by_id(self.id)
   end

   def transactions
     @invoice_repository_object.find_transactions_by_invoice_id(self.id)
   end

end
