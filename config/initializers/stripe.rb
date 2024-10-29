require 'stripe'
Rails.configuration.stripe = {
  publishable_key: "pk_test_51Q0cNIEdFftkiwBdF6YiY7oxGIbP6QB5uFWKxAmaKVnq37tQiOrw5mg49jYWyGHdxuXlcgsFwpQU6TwdaKSGi3cf00s3KFCvU5",
  secret_key: "sk_test_51Q0cNIEdFftkiwBdml2W52CvrmdIPpaI96fideTRHKtSwRoe4fy8GSaTihjkibsvSBcfTtzouhKSjf1hEqorYXg800vvy3mQpI"

}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
