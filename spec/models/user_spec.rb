require 'rails_helper'

RSpec.describe User, type: :model do
  describe "creates or updates itself from a facebook oauth hash" do

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

    let(:new_user){ User.create_from_omniauth(fb_auth, true)}  
    let(:provider){ Provider.first_or_create({provider: "facebook", uid: "12345678910", oauth_token: "qwerty123456"}) }

    it{expect(provider.provider).to eq("facebook")}
    it{expect(provider.uid).to eq("12345678910")}
    it{expect(new_user.email).to eq("daniel@example.com")}
    it{expect(new_user.name).to eq("Daniel Vysotskyi")}
    it{expect(provider.oauth_token).to eq("qwerty123456")}
   end

  describe "creates or updates itself from a linkedin oauth hash" do
      let(:li_auth){OmniAuth::AuthHash.new({
        provider: "linkedin",
        uid: "90341078954",
        info: {
          email: "daniel@example.com",
          name: "Daniel Vysotskyi"
        },
        credentials: {
          token: "123456qwerty"
        }
      })}

    let(:li_user){ User.create_from_omniauth(li_auth, true)}  
    let(:li_provider){ Provider.first_or_create({provider: "linkedin", uid: "90341078954", oauth_token: "123456qwerty"}) }

    it{expect(li_provider.provider).to eq("linkedin")}
    it{expect(li_provider.uid).to eq("90341078954")}
    it{expect(li_user.email).to eq("daniel@example.com")}
    it{expect(li_user.name).to eq("Daniel Vysotskyi")}
    it{expect(li_provider.oauth_token).to eq("123456qwerty")}
  end
end