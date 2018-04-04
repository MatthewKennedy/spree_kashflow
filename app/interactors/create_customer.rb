class CreateCustomer
  include Interactor

  def call
    customer = context.order.customer_to_kashflow

    begin
      if kashflow_customer = client_exists?(context.order.email)
        customer[:customer_id] = customer_id = kashflow_customer.first.customer_id
        context.client.update_customer(customer)
      end
    rescue
      customer_id = context.client.insert_customer(customer)
    ensure
      context.customer_id = customer_id
    end
  end

  def client_exists?(email)
    context.client.get_customer_by_email(customer_email: email)
  end
end