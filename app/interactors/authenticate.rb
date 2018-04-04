class Authenticate
  include Interactor

  def call
    if client = Kashflow.client(Spree::Config[:kashflow_user], Spree::Config[:kashflow_password])
      context.client = client
    else
      context.fail!(message: "kashflow.authenticate_user.failure")
    end
  end
end