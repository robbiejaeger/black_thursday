require 'pry'
require 'csv'

class Merchant

  def intialize({ :id => nil, :name => nil })
    @id = :id
    @name = :name
  end

  def method_that_gets_id(id)


  end

  def method_that_gets_name(name)


  end

  def method_that_creates_hash_with_above_methods?


  end


  # The merchant is one of the critical concepts in our
  # data hierarchy.
  # id - returns the integer id of the merchant
  # name - returns the name of the merchant
  # We create an instance like this:

  # m = Merchant.new({:id => 5, :name => "Turing School"})

end
