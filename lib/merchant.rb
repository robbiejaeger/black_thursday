require 'pry'
require 'csv'

class Merchant

attr_reader :id, :name

  def initialize(merchant_hash)
    merchant_hash = merchant_hash
    @id = merchant_hash[:id].to_i
    @name = merchant_hash[:name]
  end
end
