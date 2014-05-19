class ChargesController < ApplicationController
  def create
  # Amount in cents
  @amount = params[:amount]

  customer = Stripe::Customer.create(
    :email => params[:email],
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Payment On Account',
    :currency    => 'usd'
  )
  rescue Stripe::CardError => e
    render text: e.message
  else
    render text: "Thank you for your payment!"
  end
end
