require 'csv'
require_relative '../lib/transaction'

class TransactionRepository

  attr_reader :transactions, :sales_engine_object

  def initialize(csv_filepath, sales_engine_object)
    @sales_engine_object = sales_engine_object
    @transactions = []
    create_transactions(csv_filepath) unless csv_filepath.nil?
  end

  def all
    @transactions
  end

  def find_by_id(id)
    @transactions.find { |transaction| transaction.id == id }
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all{ |transaction| transaction.invoice_id == invoice_id}
  end

  def find_all_by_credit_card_number(credit_card_number)
    @transactions.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    @transactions.find_all { |transaction| transaction.result == result }
  end

  def find_invoice_by_invoice_id(invoice_id)
    @sales_engine_object.find_invoice_by_invoice_id(invoice_id)
  end

  private

  def create_transactions(csv_filepath)
    parse_csv_data(csv_filepath)
  end

  def parse_csv_data(csv_filepath)
    contents = CSV.open(csv_filepath, headers: true, header_converters: :symbol)
    contents.each do |row|
      transaction_creation_hash = {}

      transaction_creation_hash[:id] = row[:id]
      transaction_creation_hash[:invoice_id] = row[:invoice_id]
      transaction_creation_hash[:credit_card_number] = row[:credit_card_number]
      transaction_creation_hash[:credit_card_expiration_date] = row[:credit_card_expiration_date]
      transaction_creation_hash[:result] = row[:result]
      transaction_creation_hash[:created_at] = row[:created_at]
      transaction_creation_hash[:updated_at] = row[:updated_at]

      add_transaction(transaction_creation_hash)
    end
  end

  def add_transaction(transaction_creation_hash)
    @transactions << Transaction.new(transaction_creation_hash, self)
  end

  # :nocov:
  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
  # :nocov:

end
