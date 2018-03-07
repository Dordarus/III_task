class ChargesController < ApplicationController
  include ChargesHelper
  before_action :authenticate_user!
  before_action :check_author
  before_action :set_description, :amount_to_be_charged 

  def new
  end

  def create
    customer = StripeTool.create_customer(email: params[:stripeEmail], 
                                          stripe_token: params[:stripeToken])

    charge = StripeTool.create_charge(customer_id: customer.id, 
                                      amount: @amount,
                                      description: @description)

    current_user.create_subscription
    redirect_to users_path, success: "Thanks, you paid #{formatted_amount(@amount)}! Now you can view author's profiles."

  rescue Stripe::CardError => e
    redirect_to new_charge_path, danger: e.message
  end

  private

    def set_description
      @description = "A month's subscription"
    end

    def amount_to_be_charged
      @amount = 500
    end
end
