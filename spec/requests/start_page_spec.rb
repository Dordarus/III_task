require 'rails_helper'

RSpec.describe "user logs in" do
  scenario "using omniauth-facebook" do
    stub_omniauth
    visit root_path
    expect(page).to have_content("Log in with Facebook")
    click_link "Log in with Facebook"
    expect(page).to have_content("Daniel Vysotskyi")
    expect(page).to have_link("Sign out")
  end

  scenario "using omniauth-linkedin" do
    stub_omniauth
    visit root_path
    expect(page).to have_content("Log in with LinkedIn")
    click_link "Log in with LinkedIn"
    expect(page).to have_content("Daniel Vysotskyi")
    expect(page).to have_link("Sign out")
  end

  scenario "using Devise registration" do
    visit root_path
    expect(page).to have_content("Register")
    click_link "Register"
    expect(page).to have_selector('div.alert.alert-info') 
  end

  def stub_omniauth
    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        provider: "facebook",
        uid: "12345678910",
        info: {
          email: "daniel@example.com",
          name: "Daniel Vysotskyi"
        },
        credentials: {
          token: "qwerty123456"
        }
      })

    OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({
    provider: "linkedin",
    uid: "12345678910",
    info: {
        email: "daniel@example.com",
        name: "Daniel Vysotskyi"
        },
    credentials: {
        token: "123456qwerty"
        }
    })
  end
end