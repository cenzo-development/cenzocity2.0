class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      pass_code = PassCodeGenerator.generate_passcode(user.id)
      user.pass_code = Digest::SHA512.hexdigest pass_code
      Utilities.send_pass_code(pass_code, user.mobile_phone) if user.save
      flash[:success] = "logged in sucessfully"
      redirect_to passcode_path
    else
      flash.now[:error] = "Invalid email and password combination"
      render "new"
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path, notice: "logged out!" 
  end

end
