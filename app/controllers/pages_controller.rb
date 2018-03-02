class PagesController < ApplicationController
    respond_to :html, :json
    
    def index
        if user_signed_in?
            if !current_user.profile_user? 
                if current_user.allow_user?
                    redirect_to users_path
                else
                    redirect_to new_charge_path
                end
            else
                redirect_to users_path
            end
        else
            render :index
        end
    end
end
