module ChargesHelper
    def formatted_amount(amount_in_cents)
        ActionController::Base.helpers.number_to_currency(amount_in_cents / 100)
    end
end
