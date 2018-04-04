class SetupCurrencies
  include Interactor

  def call
    context.currencies = context.client.get_currencies
    context.default_currency = context.currencies.detect { |c| c.is_default.eql?('1') }
    context.order_currency = context.currencies.detect { |c| c.currency_code.eql?(context.order.currency) } if context.order
  end
end