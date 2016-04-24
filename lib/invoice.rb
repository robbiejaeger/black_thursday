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

   def customer
     @invoice_repository_object.find_customer_by_customer_id(self.customer_id)
   end

   def is_paid_in_full?
     transactions.any? {|transaction| transaction.result == "success"}
   end

   def total
     if is_paid_in_full?
       @invoice_repository_object.sum_all_items_and_quanities(self.id)
     else
       0
     end
   end

end
