module Spree
  AppConfiguration.class_eval do
    preference :kashflow_user, :string
    preference :kashflow_password, :string
    preference :kashflow_shipping_code, :string, default: 190
    preference :kashflow_sale_of_goods_code, :string, default: 100
  end
end