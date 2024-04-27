# README

Rails 7+ with one-time payments and subscriptions using Stripe.

- user creates an account and is assigned a Stripe customer ID
- unsubscribed user can see "free" posts
- subscribed user can see "free" and "premium" posts
- user can visit pricing page and see eligible prices from Stripe dashboard
- Stripe Checkout
- user can pay once (lifetime subscription)
- user can subscribe to monthly or yearly plan
- user can visit Stripe billing portal to see his invoices, cancel plan, upgrade plan, change billing address
- no extra dependencies (like `gem "pay"`)

### Set up app

Step 1. Run Rails app and seed some data

```shell
bundle install
rails db:setup
# console tab #1
rails s
```

Step 2. Add Stripe secret key in `config/initializers/stripe.rb`
Step 3. Add Stripe webhook key in `app/controllers/stripe/webhooks_controller.rb`
Step 4. Install [Stripe CLI](https://docs.stripe.com/stripe-cli)
Step 5. Listen to stripe webhooks

```shell
stripe login
# console tab #2
stripe listen --forward-to localhost:3000/stripe/webhooks
```
