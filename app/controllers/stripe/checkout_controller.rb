class Stripe::CheckoutController < ApplicationController
  def pricing
    lookup_keys = %w[monthly yearly lifetime]
    @prices = Stripe::Price.list(lookup_keys: lookup_keys, active: true, expand: ['data.product']).data.sort_by(&:unit_amount)
  end

  def new
    price = Stripe::Price.retrieve(params[:price_id])
    @session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      mode: mode(price),
      line_items: [{
        quantity: 1,
        price: params[:price_id]
      }],
      return_url: pricing_url,
      ui_mode: 'embedded'
      })
  end

  def checkout
    price = Stripe::Price.retrieve(params[:price_id])
    session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      mode: mode(price),
      line_items: [{
        quantity: 1,
        price: params[:price_id]
      }],
      success_url: stripe_checkout_success_url,
      cancel_url: stripe_checkout_cancel_url,
      })
    redirect_to session.url, allow_other_host: true
  end

  def success
    flash[:notice] = "success"
    redirect_to pricing_path
  end
  
  def cancel
    flash[:alert] = "failure"
    redirect_to pricing_path
  end

  private

  MODES = {
    'recurring' => 'subscription',
    'one_time' => 'payment'
  }.freeze

  def mode(price)
    MODES[price.type]
  end
end
