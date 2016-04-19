require 'pry'
require 'csv'
# require 'merchant'

class MerchantRepository

# @contents = CSV.open 'merchants.csv', headers: true, header_converters: :symbol

  def all
    merchants = []
    lines = File.readlines "./data/merchants.csv"
    lines.each do |line|
      merchants << lines
    end
    #returns an array of all known Merchant instances
  end

  def find_by_id
    #returns either nil or an instance of Merchant
    #with a matching ID
  end

  def find_by_name
    #returns either nil or an instance of Merchant
    #having done a case insensitive search
  end

  def find_all_by_name
    #  returns either [] or one or more matches which
    # contain the supplied name fragment,
    # case insensitive
  end
end

merch = MerchantRepository.new
merch.all
