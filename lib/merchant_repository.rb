require 'pry'
require 'csv'
# require 'merchant'

class MerchantRepository
  attr_reader :all_merchants

  def intialize
    @all_merchants = []
  end

  def read_merchants
    File.readlines "./data/merchants.csv"
  end

  def all  #returns an array of all known Merchant instances
    @all_merchants = []
    read_merchants.each do |line|
      @all_merchants << line
    end
  end

  def find_by_id(id) ##returns either nil or an instance of Merchant with a matching ID
    read_merchants.each do |line|
      columns = line.split(",")
      id = columns[0] #ask about this.....
    end
  end

  def find_by_name
    read_merchants.each do |line|
      columns = line.split(",")
      id = columns[1] #ask about this.....
    #returns either nil or an instance of Merchant
    #having done a case insensitive search
    end
  end

  def find_all_by_name
    #  returns either [] or one or more matches which
    # contain the supplied name fragment,
    # case insensitive
  end
end

merch = MerchantRepository.new
puts merch.all
