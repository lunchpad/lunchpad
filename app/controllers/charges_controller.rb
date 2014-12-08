class ChargesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    if charge
      redirect_to accounts_path
    end
  end

  private

  def charge
    charge = (params[:amount].to_f * 100).to_i
    card = params[:stripeToken]

    # if current_user.stripe_id?
    #   customer_id = current_user.stripe_id
    # else
      customer = Stripe::Customer.create(:email => current_user.email, :card => card)
      customer_id = customer.id
      # Save down stripe_id to customer
    # end

    Stripe::Charge.create(:amount => charge, :currency => "usd", :customer => customer.id)
  end
end