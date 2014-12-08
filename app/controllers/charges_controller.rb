class ChargesController < ApplicationController

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
    # Amount in cents
    @amount = params[:amount]

    customer = Stripe::Customer.create(
      :email => 'example@stripe.com',
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end



# def create
#   @amount = user.input
#
#   customer = Stripe::Customer.create(
#     :email => 'user.email',
#     :card  => params[:stripeToken]
#   )
#
#   save_stripe_customer_id(user, customer.id)
#
#   charge = Stripe::Charge.create(
#     :customer    => customer.id,
#     :amount      => @amount,
#     :description => 'Rails Stripe customer',
#     :currency    => 'usd'
#   )
#
# rescue Stripe::CardError => e
#   flash[:error] = e.message
#   redirect_to charges_path
# end
#
# def save_stripe_custore_id
#
# end