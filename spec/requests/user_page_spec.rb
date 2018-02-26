require 'rails_helper'
RSpec.describe "show user page", type: :request  do
    subject{ page }
    describe "when authenticated" do
        let(:user){FactoryBot.create(:confirmed_user)}
        before do 
            login_as(user, :scope => :user)
            visit user_path(user)
        end

        it { should have_content(user.name) }
        it { should have_link('Profile',     href: user_path(user)) }
        it { should have_link('Sign out',    href: destroy_user_session_path) }
        it { should_not have_link('Log in',  href: new_user_session_path) }
        it { should have_link('Link GitHub account?',    href: user_github_omniauth_authorize_url()) }
    end

    describe "when not authenticated" do
        before do 
            visit user_path(1)
        end

        it { should_not have_content("Some Name") }
        it { should_not have_link('Profile',     href: user_path(1)) }
        it { should_not have_link('Sign out',    href: destroy_user_session_path) }
        it { should_not have_link('Link GitHub account?',    href: user_github_omniauth_authorize_url()) }
        it { should have_content('The page you were looking for doesn\'t exist') }
    end

    describe "when user click GitHub button" do
        let(:user){FactoryBot.create(:confirmed_user)}
        let(:gh_provider){ Provider.first_or_create({provider: "linkedin", uid: "90341078954", oauth_token: "123456qwerty", user_id: user.id}) }
        before do 
            login_as(user, :scope => :user)
            visit user_path(user)
        end

        describe "should change content" do
            it { should_not have_link('Link GitHub account?',    href: user_github_omniauth_authorize_path) }
        end
    end
end