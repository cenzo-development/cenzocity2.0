class SessionsController < ApplicationController

  def new

  end

  def create
  user = User.find_by_email(params[:email])
  if user and user.authenticate(params[:password])
    session[:user_id] = user.id
    pass_code = PassCodeGenerator.generate_passcode(user.id)
    user.pass_code = Digest::SHA512.hexdigest pass_code
  end

  unless user.save && Utilities.send_pass_code(pass_code, user.mobile_phone)
    flash.now[:error] = "Invalid email and password combination"
    render "new"
  end

  flash[:success] = "logged in sucessfully"
  redirect_to passcode_path
end

def destroy
end

end 
