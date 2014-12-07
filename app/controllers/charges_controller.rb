class ChargesController < ApplicationController
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