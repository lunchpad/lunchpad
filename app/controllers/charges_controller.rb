class ChargesController < ApplicationController
  before_action :authenticate_user!

  def index
    @accounts = current_user.accounts
  end

  def apply
    @account = Account.find(params[:account])
    payment = (params[:payment]).to_i * 100
    if current_user.wallet >= payment
      @account.decrement!(:balance, payment)
      current_user.decrement!(:wallet, payment)
    else
      flash[:alert] = "Something went wrong. Make sure you have enough money in your wallet to apply this payment."
    end
    redirect_to charges_path
  end


  def new
  end

  def create
    if charge
      redirect_to charges_path
    end
  end

  private

  def charge
    charge = (params[:amount].to_f * 100).to_i

    # Comment out while site is open to public
    # card = params[:stripeToken]

    current_user.increment!(:wallet, charge)

    # if current_user.stripe_id?
    #   customer_id = current_user.stripe_id
    # else
    #   customer = Stripe::Customer.create(:email => current_user.email, :card => card)
    #   customer_id = customer.id
      # Save down stripe_id to customer
    # end

    # Stripe::Charge.create(:amount => charge, :currency => "usd", :customer => customer.id)
  end
end
