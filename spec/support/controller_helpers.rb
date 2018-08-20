

module ControllerHelpers

  def log_in(user)
   controller.stubs(:current_user).returns(user)
  end

end
