module Spree
  module Admin
    OrdersController.class_eval do
      before_action :load_order, only: :sync_kashflow

      def sync_kashflow
        @order.send_order_kashflow

        flash[:success] = Spree.t(:order_syncing_with_kashflow)

        redirect_back fallback_location: spree.edit_admin_order_url(@order)
      end
    end
  end
end