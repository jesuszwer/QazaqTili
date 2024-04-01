class SessionsController < ApplicationController
  def new
    @page_title = "Вход"
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_to root_path, norice: 'Logged in!'
    else
      flash.now[:alert] = 'Email or password is invalid'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "Вы вышли из аккаунта!"
  end
end
