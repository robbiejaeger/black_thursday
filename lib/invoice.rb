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
     @status = invoice_hash[:status]
     @created_at = Time.parse(invoice_hash[:created_at])
     @updated_at = Time.parse(invoice_hash[:updated_at])
   end





end


# id - returns the integer id
# customer_id - returns the customer id
# merchant_id - returns the merchant id
# status - returns the status
# created_at - returns a Time instance for the date the item was first created
# updated_at - returns a Time instance for the date the item was last modified
