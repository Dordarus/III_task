class PagesController < ApplicationController
    before_action :authenticate_user!
    before_action :check_author
    
    def index
        if current_user.allow_user?
            redirect_to users_path
        else
            redirect_to new_charge_path
        end
    end
end