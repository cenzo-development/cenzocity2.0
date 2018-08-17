require 'rails_helper'

RSpec.describe PasscodeController, type: :controller do

  describe "GET #enter" do
    it "returns http success" do
      get :enter
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #submit" do
    it "returns http success" do
      get :submit
      expect(response).to have_http_status(:success)
    end
  end

end
