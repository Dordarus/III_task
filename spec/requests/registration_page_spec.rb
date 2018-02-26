require 'rails_helper'

RSpec.describe "Authentication", type: :request do

    subject{ page }

    describe "sign up page" do
        before{ visit new_user_registration_path }
    
        let(:submit) {"Sign up"}
    
        describe "with invalid info" do
          it "should not create a user" do
            expect{click_button submit}.not_to change(User, :count)
            end  
            it { should have_selector('div.alert') }
        end
    
        describe "with valid information" do
        let(:user){FactoryBot.create(:confirmed_user)}
          before do
            login_as(user, :scope => :user)
            fill_in "Name",         with: user.name
            fill_in "Email",        with: user.email
            fill_in "Password",     with: user.password
            fill_in "Password confirmation", with: user.password_confirmation
        end
    
          describe "should change content" do
            before {click_button submit}
            it { should have_content(user.name) }
          end
        end
    end
end
