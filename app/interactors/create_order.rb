class CreateOrder
  include Interactor

  def call
    invoice_number = context.client.insert_invoice(transform(context.order.to_kashflow))
    context.order.update_attribute(:kashflow_number, invoice_number)
  end

  def transform(order)
    order[:customer_id] = context.customer_id
    order
  end
end