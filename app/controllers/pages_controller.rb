class PagesController < ApplicationController
    respond_to :html, :json
    
    def index
        if user_signed_in?
            if current_user.profile_user?
                redirect_to new_charge_path
            else
                redirect_to users_path
            end
        else
            render :index
        end
    end
end
