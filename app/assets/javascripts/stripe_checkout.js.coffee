handler = StripeCheckout.configure(
  key: "pk_rkGZsTKZuD7Bh4uTZVbhV0na7SSEV"
  image: '/images/stripe-logo.png'
  token: (token, args) ->
)

# Use the token to create the charge with a server-side script.
# You can access the token ID with `token.id`
$(document).on "click", "#stripeCheckout", (e) ->
  amount = (parseFloat $('.amount').val()) * 100
  if amount > 0
    handler.open
      name: "Brown Web Design, Inc."
      description: "Payment on account"
      amount: amount
  else
    alert "Please enter an amount first."

  e.preventDefault()
  return
