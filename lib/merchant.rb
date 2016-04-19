require 'pry'
require 'csv'

class Merchant

attr_reader :id, :name

  def initialize(merchant_hash)
    merchant_hash = merchant_hash
    @id = merchant_hash[:id].to_i
    @name = merchant_hash[:name]
  end



  # The merchant is one of the critical concepts in our
  # data hierarchy.
  # id - returns the integer id of the merchant
  # name - returns the name of the merchant
  # We create an instance like this:

  # m = Merchant.new({:id => 5, :name => "Turing School"})

end
