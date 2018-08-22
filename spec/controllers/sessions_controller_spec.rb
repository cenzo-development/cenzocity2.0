require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let(:user) { FactoryBot.create(:user, email: "frank@example.com", password: "pa$$word", mobile_phone: "0685291403", pass_code: Digest::SHA512.hexdigest('666666'))}
  let(:usr)  {mock('user')}
  let (:code_generator) {mock('PasscodeGenerator')}
  let (:utilities) {mock("Utilities")}
  before {log_in(usr)}
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid email and password combination" do

      it "creates a new session" do
        usr.expects(:authenticate).with(user.password).at_most_once
        code_generator.expects(:generate_passcode).with(user.id).at_most_once
        utilities.expects(:send_pass_code).with(user.pass_code, user.mobile_phone).at_most_once
        params = {email: user.email, password: user.password}
        post :create, {params: params}
        expect(controller.session[:user_id]).to eq user.id
      end
      it "renders redirects to passcode page" do
        usr.expects(:authenticate).with(user.password).at_most_once
        code_generator.expects(:generate_passcode).with(user.id).at_most_once
        utilities.expects(:send_pass_code).with(user.pass_code, user.mobile_phone).at_most_once
        params = {email: user.email, password: user.password}
        post :create, {params: params}
        expect(response).to redirect_to passcode_path
      end
      it "sets login success message" do
        usr.expects(:authenticate).with(user.password).at_most_once
        code_generator.expects(:generate_passcode).with(user.id).at_most_once
        utilities.expects(:send_pass_code).with(user.pass_code, user.mobile_phone).at_most_once
        params = {email: user.email, password: user.password}
        post :create, {params: params}
        expect(controller.flash[:success]).to_not be nil
      end
    end

    context "with invalid email and password" do
      it "it should re-render new template with wrong email" do
        usr.expects(:authenticate).with(user.password).at_most_once
        params = {email: 'mavel@mail.com', password: user.password}
        post :create, {params: params}
        expect(response).to render_template("new")
      end
      it "it should re-render new template with wrong password" do
        usr.expects(:authenticate).with(user.password).at_most_once
        params = {email: user.email, password: 'happy'}
        post :create, {params: params}
        expect(response).to render_template("new")

      end
      it "sets error message with wrong password" do
        usr.expects(:authenticate).with(user.password).at_most_once
        params = {email: user.email, password: 'happy'}
        post :create, {params: params}
        expect(controller.flash[:error]).to_not be nil
      end
      it "sets error message with wrong email" do
        usr.expects(:authenticate).with(user.password).at_most_once
        params = {email: 'mavel@mail.com', password: user.password}
        post :create, {params: params}
        expect(controller.flash[:error]).to_not be nil
      end
    end
  end


  describe "DELETE #destroy" do
    it "deletes the current user session" do
      delete :destroy
      expect(controller.session[:user_id]).to be_nil
    end
    it "sets logout info message" do
      delete :destroy
      expect(subject.flash[:notice]).to_not be nil
    end
    it "redirects to login page" do
      delete :destroy
      expect(subject.response).to redirect_to new_session_path
    end
  end

end
