require_relative '../test/test_helper'


class InvoiceRepoTest < Minitest::Test
  def setup
    @file = File.expand_path("../test/fixtures/invoices.csv", __dir__)
  end

  def test_it_can_hold_a_new_invoice
    data = FileReader.new.read(@file)
    repo = InvoiceRepository.new(data, "sales_engine")
    refute repo.instances.empty?
  end

  def test_it_can_return_correct_size
    data = FileReader.new.read(@file)
    repo = InvoiceRepository.new(data, "sales_engine")
    result = repo.all
    assert_equal  8 , result.size

  end

  def test_it_returns_all_invoices
    data = FileReader.new.read(@file)
    repo = InvoiceRepository.new(data, "sales_engine")
    result = repo.all
    result.map do |invoice|
      assert_equal Invoice, invoice.class
    end
  end

  def test_it_can_find_random
    data = FileReader.new.read(@file)
    repo = InvoiceRepository.new(data, "sales_engine")
    random = repo.random
    invoices = repo.instances
    invoices.delete(random)
    refute invoices.include?(random)
  end

  def test_it_can_find_an_instance_based_off_of_id
    data = FileReader.new.read(@file)
    repo = InvoiceRepository.new(data, "sales_engine")
    result = repo.find_by_id(2)
    assert_equal 1, result.customer_id
  end

  def test_it_can_find_an_instance_based_off_of_merchant_id
    data = FileReader.new.read(@file)
    repo = InvoiceRepository.new(data, "sales_engine")
    result = repo.find_by_merchant_id(26)
    assert_equal 1, result.customer_id
  end

  def test_it_can_find_an_instance_based_off_of_customer_id
    data = FileReader.new.read(@file)
    repo = InvoiceRepository.new(data, "sales_engine")
    result = repo.find_by_customer_id(1)
    assert_equal 26, result.merchant_id
  end

  def test_it_can_find_an_instance_based_off_of_status
    data = FileReader.new.read(@file)
    repo = InvoiceRepository.new(data, "sales_engine")
    result = repo.find_by_status("ShiPped")
    assert_equal 1, result.customer_id
  end

  def test_it_can_find_an_instance_based_off_of_created_at
    data = FileReader.new.read(@file)
    repo = InvoiceRepository.new(data, "sales_engine")
    result = repo.find_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal 1, result.id
  end

  def test_it_can_find_an_instance_based_off_updated_at
    data = FileReader.new.read(@file)
    repo = InvoiceRepository.new(data, "sales_engine")
    result = repo.find_by_updated_at("2012-03-12 05:54:09 UTC")
    assert_equal 2, result.id
  end


  def test_it_can_find_all_instances_based_off_of_id
    data = FileReader.new.read(@file)
    repo = InvoiceRepository.new(data, "sales_engine")
    result = repo.find_all_by_id(2)
    assert_equal 1, result[0].customer_id

  end

  def test_it_can_find_all_instances_based_off_of_created_at
    data = FileReader.new.read(@file)
    repo = InvoiceRepository.new(data, "sales_engine")
    result = repo.find_all_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal 2, result.size
  end

  def test_it_can_find_all_instances_based_off_of_updated_at
    data = FileReader.new.read(@file)
    repo = InvoiceRepository.new(data, "sales_engine")
    result = repo.find_all_by_updated_at("2012-03-12 05:54:09 UTC")
    assert_equal 2, result.size
  end

  def test_it_can_move_instances_up_to_its_sales_engine_for_invoice_items
    engine = Minitest::Mock.new
    invoice_repo = InvoiceRepository.new([{id: 2, name: "Joe"}], engine)
    engine.expect(:find_all_invoice_items_by_invoice_id, [], [2])
    invoice_repo.find_all_invoice_items_by_invoice_id(2)
    engine.verify
  end

  def test_it_can_move_instances_up_to_its_sales_engine_for_transactions
    engine = Minitest::Mock.new
    invoice_repo = InvoiceRepository.new([{id: 2, name: "Joe"}], engine)
    engine.expect(:find_all_transactions_by_invoice_id, [], [2])
    invoice_repo.find_all_transactions_by_invoice_id(2)
    engine.verify
  end

  def test_it_can_move_instances_up_to_its_sales_engine_for_items
    engine = Minitest::Mock.new
    invoice_repo = InvoiceRepository.new([{id: 2, name: "Joe"}], engine)
    engine.expect(:find_all_items_by_invoice_id, [], [2])
    invoice_repo.find_all_items_by_invoice_id(2)
    engine.verify
  end

  def test_it_can_move_instances_up_to_its_sales_engine_for_a_customer
    engine = Minitest::Mock.new
    invoice_repo = InvoiceRepository.new([{id: 2, name: "Joe"}], engine)
    engine.expect(:find_a_customer_by_invoice_id, [], [2])
    invoice_repo.find_a_customer_by_invoice_id(2)
    engine.verify
  end

  def test_it_can_move_instances_up_to_its_sales_engine_for_a_merchant
    engine = Minitest::Mock.new
    invoice_repo = InvoiceRepository.new([{id: 2, name: "Joe"}], engine)
    engine.expect(:find_a_merchant_by_invoice_id, [], [2])
    invoice_repo.find_a_merchant_by_invoice_id(2)
    engine.verify
  end

end
