require "time"

class Transaction

  attr_reader :id, :invoice_id, :credit_card_number,
              :credit_card_expiration_date, :result, :created_at, :updated_at

  def initialize(transaction_hash, transaction_repository_object)
    @transaction_repository_object = transaction_repository_object
    @id = transaction_hash[:id].to_i
    @invoice_id = transaction_hash[:invoice_id].to_i
    @credit_card_number = transaction_hash[:credit_card_number].to_i
    @credit_card_expiration_date =transaction_hash[:credit_card_expiration_date]
    @result = transaction_hash[:result]
    @created_at = Time.parse(transaction_hash[:created_at])
    @updated_at = Time.parse(transaction_hash[:updated_at])
  end

  def invoice
    @transaction_repository_object.find_invoice_by_invoice_id(self.invoice_id)
  end

end
