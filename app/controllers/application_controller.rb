class ApplicationController < ActionController::Base
  def check_login
    unless logged_in?
      flash[:alert] = 'Вы должны войти в аккаунт!'
      redirect_to root_path
    end
  end
end
