handler = StripeCheckout.configure(
  key: $("input[data-key]").data("key")
  image: '/images/stripe-logo.png'
  token: (token, args) ->
    amount = (parseFloat $('.amount').val()) * 100
    $.post("/charges"
      stripeToken: token.id
      amount: amount
      email: token.email
    ).done (data) ->
      $( ".cc-form" ).hide()
      $( ".cc-result" ).show().find(".alert-box").html(data)
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
