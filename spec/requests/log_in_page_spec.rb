require 'rails_helper'

RSpec.describe "Authentication", type: :request do

subject{ page }

    describe "sign_in" do

        before { visit new_user_session_path }

        describe "with invalid information" do
            before { click_button "Log in" }

            it { should have_title('Log In') }
            it { should have_selector('div.alert') }

            describe "after visiting another page" do
                before { click_link "HOME" }
                it { should_not have_selector('div.alert.alert-danger') }
            end
        end
    

        describe "with valid information" do
            let(:user) { FactoryBot.create(:confirmed_user) }
            before do
                fill_in "Email",    with: user.email
                fill_in "Password", with: user.password
                click_button "Log in"
            end

            it { should have_link('Profile',     href: user_path(user)) }
            it { should have_link('Sign out',    href: destroy_user_session_path) }
            it { should_not have_link('Log in', href: new_user_session_path) }

            describe "followed by signout" do
                before { click_link "Sign out" }
                it { should have_link('Log in') }
            end
        end
    end
end