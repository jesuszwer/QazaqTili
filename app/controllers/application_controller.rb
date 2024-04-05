class ApplicationController < ActionController::Base
  def check_login
    redirect_to login_path unless logged_in?
  end
end
