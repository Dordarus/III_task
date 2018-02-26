require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      visit user_path(1)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      visit edit_user_path(1)
      expect(response).to have_http_status(:success)
    end
  end
end
