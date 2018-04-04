class PlaceOrderKashflow
  include Interactor::Organizer

  organize Authenticate, SetupCurrencies, CreateCustomer, CreateOrder, CreateItems, CreatePayment
end
