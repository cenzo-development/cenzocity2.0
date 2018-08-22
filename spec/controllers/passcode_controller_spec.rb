require 'rails_helper'

RSpec.describe PasscodeController, type: :controller do
  let(:user) { FactoryBot.create(:user, email: "frank@example.com", password: "pa$$word", pass_code: Digest::SHA512.hexdigest('666666'))}
  let(:code_checker) {mock('PassCodeChecker')}
  before{log_in(user)}

  describe "GET #enter" do
    it "returns http success" do
      get :enter
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #submit" do
    context "with valid passcode" do
      it "redirects to the homepage" do
        code_checker.expects(:check_pass_code).with(user, '666666').at_most_once
        params = {smscode: '666666'}
        post :submit, {params: params}
        expect(response).to redirect_to root_path
      end
    end
    context "when passcode is numeric with length < 6" do
      it "should re-render the enter template" do
        params = {smscode: '234'}
        post :submit, {params: params}
        expect(response).to render_template("enter")
      end
      it "sets error message" do
        params = {smscode: '234'}
        post :submit, {params: params}
        expect(controller.flash[:error]).not_to be nil
      end
    end
  end
  context "when passcode is numeric with length > 6" do
    it "should re-render the enter template" do
      params = {smscode: '1237896543'}
      post :submit, {params: params}
      expect(response).to render_template("enter")
    end
    it "sets error message" do
      params = {smscode: '1234578043'}
      post :submit, {params: params}
      expect(controller.flash[:error]).not_to be nil
    end
  end
  context "when passcode is non-numeric" do
    it "should re-render the enter template" do
      params = {smscode: 'wwwwww'}
      post :submit, {params: params}
      expect(response).to render_template("enter")
    end
  end


end
