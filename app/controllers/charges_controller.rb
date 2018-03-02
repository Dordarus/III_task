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

    current_user.create_subscription
    flash[:success] = "Thanks, you paid #{formatted_amount(@amount)}! Now you can view profiles."
    redirect_to users_path

  rescue Stripe::CardError => e
    flash[:danger] = e.message
    redirect_to new_charge_path
  end

  private

    def set_description
      @description = "A month's subscription"
    end

    def amount_to_be_charged
      @amount = 500
    end
end
