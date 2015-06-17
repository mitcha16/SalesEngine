require_relative '../lib/file_reader'
require_relative '../lib/merchant_repo'
require_relative '../lib/customer_repo'
require_relative '../lib/transactions_repo'
require_relative '../lib/invoice_repo'
require_relative '../lib/invoice_items_repo'
require_relative '../lib/items_repo'
require 'csv'

class SalesEngine

  def get_data
    reader         = FileReader.new
    @merchants     = reader.read(File.expand_path("./data/merchants.csv"))
    @customers     = reader.read(File.expand_path("./data/customers.csv"))
    @transactions  = reader.read(File.expand_path("./data/transactions.csv"))
    @invoices      = reader.read(File.expand_path("./data/invoices.csv"))
    @invoice_items = reader.read(File.expand_path("./data/invoice_items.csv"))
    @items         = reader.read(File.expand_path("./data/items.csv"))
  end

  def startup(data = get_data())
    data
    merchant_repo      = MerchantRepository.new(@merchants, self)
    customer_repo      = CustomerRepository.new(@customer, self)
    transactions_repo  = TransactionsRepository.new(@transactions, self)
    invoices_repo      = InvoiceRepository.new(@invoices, self)
    invoice_items_repo = InvoiceItemsRepository.new(@invoice_items, self)
    items_repo         = ItemsRepo.new(@items, self)
  end


end

SalesEngine.new.startup
