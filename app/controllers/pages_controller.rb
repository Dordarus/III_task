class PagesController < ApplicationController
    respond_to :html, :json
    
    def index
        if user_signed_in?
            redirect_to new_charge_path
        else
            render :index
        end
    end
end
