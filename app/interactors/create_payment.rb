class CreatePayment
  include Interactor

  def call
    context.order.payments.completed.each do |payment|
      context.client.insert_invoice_payment(transform(payment.to_kashflow))
    end

    context.order.touch :kashflow_synced_at
  end

  def transform(payment)
    if context.order.currency == context.default_currency.currency_code
      return payment
    end

    payment[:pay_amount] = (payment[:pay_amount] / context.order_currency.exchange_rate.to_f).round(2)
    payment[:pay_note] = Spree.t(:currency_converted_from_to, from: context.order.currency, to: context.default_currency.currency_code)
    payment
  end
end
