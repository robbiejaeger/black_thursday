require 'pry'
require "bigdecimal"
require "bigdecimal/util"
require "time"

class Customer

  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def intialize(customer_hash, customer_repository_object)
    @customer_repository_object = customer_repository_object
    @id = customer_hash[:id].to_i
    @customer_id = customer_hash[:customer_id].to_i
    


end




# The customer has the following data accessible:
#
# id - returns the integer id
# first_name - returns the first name
# last_name - returns the last name
# created_at - returns a Time instance for the date the customer was first created
# updated_at - returns a Time instance for the date the customer was last modified
# We create an instance like this:
#
# c = Customer.new({
#   :id => 6,
#   :first_name => "Joan",
#   :last_name => "Clarke",
#   :created_at => Time.now,
#   :updated_at => Time.now
# })
