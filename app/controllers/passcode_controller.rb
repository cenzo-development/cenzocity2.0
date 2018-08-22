class PasscodeController < ApplicationController

  #before_action :authorize

  def enter
  end

  def submit
    code = params[:smscode]
    user = User.find_by_pass_code(Digest::SHA512.hexdigest(code)) if code and is_numeric_code?(code)
    if user && valid_code?(code, user)
      redirect_to root_path
    else
      flash.now[:error] = "you have entered an invalid passcode"
      render "enter"
    end
  end


  private

  def valid_code?(code, user)
    !code.nil? && code.length == 6 && PassCodeChecker.check_pass_code(user, code)
  end

  def is_numeric_code?(code)
    true if Float(code) rescue false
  end

end
