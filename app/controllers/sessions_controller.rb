class SessionsController < ApplicationController

  def new

  end

  def create
    flash[:success] = "logged in sucessfully"
    redirect_to passcode_path 
  end

  def destroy
  end


end
