class OrderKashflowJob < ApplicationJob
  queue_as :default

  def perform(order)
    PlaceOrderKashflow.call(order: order)
  end
end
