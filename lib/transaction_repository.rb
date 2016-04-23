require 'csv'
require_relative '../lib/transaction'

class TransactionRepository

  attr_reader :transactions, :sales_engine_object

  def initialize(csv_filepath, sales_engine_object)
    @sales_engine_object = sales_engine_object
    @transactions = []
    create_transactions(csv_filepath)
  end

  def all
    @transactions
  end

  def find_by_id(id)
    @transactions.find { |transaction| transaction.id == id }
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all { |transaction| transaction.invoice_id == invoice_id }
  end

  def find_all_by_credit_card_number(credit_card_number)
    @transactions.find_all { |transaction| transaction.credit_card_number == credit_card_number }
  end

  def find_all_by_result(result)
    @transactions.find_all { |transaction| transaction.result == result }
  end

  private

    def create_transactions(csv_filepath)
      parse_csv_data(csv_filepath)
    end

    def parse_csv_data(csv_filepath)
      contents = CSV.open(csv_filepath, headers: true, header_converters: :symbol)
      contents.each do |row|
        id = row[:id]
        invoice_id = row[:invoice_id]
        credit_card_number = row[:credit_card_number]
        credit_card_expiration_date = row[:credit_card_expiration_date]
        result = row[:result]
        created_at = row[:created_at]
        updated_at = row[:updated_at]

        create_transaction_hash(id,invoice_id,credit_card_number,credit_card_expiration_date,result,created_at,updated_at)
      end
    end

    def create_transaction_hash(id, invoice_id, credit_card_number, credit_card_expiration_date, result, created_at, updated_at)
      transaction_creation_hash = {}
      transaction_creation_hash[:id] = id
      transaction_creation_hash[:invoice_id] = invoice_id
      transaction_creation_hash[:credit_card_number] = credit_card_number
      transaction_creation_hash[:credit_card_expiration_date] = credit_card_expiration_date
      transaction_creation_hash[:result] = result
      transaction_creation_hash[:created_at] = created_at
      transaction_creation_hash[:updated_at] = updated_at
      transaction_creation_hash
      add_transaction(transaction_creation_hash)
    end

    def add_transaction(transaction_creation_hash)
      @transactions << Transaction.new(transaction_creation_hash, self)
    end

    def inspect
      "#<#{self.class} #{@transactions.size} rows>"
    end

end
