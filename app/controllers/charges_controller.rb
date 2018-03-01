class ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_description, :amount_to_be_charged 

  def new
  end

  def create
    customer = StripeTool.create_customer(email: params[:stripeEmail], 
                                          stripe_token: params[:stripeToken])

    charge = StripeTool.create_charge(customer_id: customer.id, 
                                      amount: @amount,
                                      description: @description)

  redirect_to thanks_path
  rescue Stripe::CardError => e
    flash[:danger] = e.message
    redirect_to new_charge_path
  end

  def thanks
  end

  private

    def set_description
      @description = "A month's subscription"
    end

    def amount_to_be_charged
      @amount = 500
    end
end
