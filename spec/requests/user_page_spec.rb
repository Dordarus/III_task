require 'rails_helper'
RSpec.describe "show user page", type: :request  do
    subject{ page }
    describe "when authenticated" do
        
        let(:fb_auth){OmniAuth::AuthHash.new({
            provider: "facebook",
            uid: "12345678910",
            info: {
            email: "daniel@example.com",
            name: "Daniel Vysotskyi"
            },
            credentials: {
            token: "qwerty123456"
            }
        })}

        let(:user){User.create_from_omniauth(fb_auth, true)}
        before do 
            login_as(user, :scope => :user)
            visit user_path(user)
        end

        it { should have_content(user.name) }
        it { should have_link('Profile',     href: user_path(user)) }
        it { should have_link('Sign out',    href: destroy_user_session_path) }
        it { should_not have_link('Log in', href: new_user_session_path) }
    end

    describe "when not authenticated" do
        before do 
            visit user_path(1)
        end

        it { should_not have_content("Some Name") }
        it { should_not have_link('Profile',     href: user_path(1)) }
        it { should_not have_link('Sign out',    href: destroy_user_session_path) }
        it { should have_link('Log in', href: new_user_session_path) }
    end
end