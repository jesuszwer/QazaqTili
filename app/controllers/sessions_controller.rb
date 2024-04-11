class SessionsController < ApplicationController

  before_action :check_login , only: [:destroy]

  def new
    @page_title = "Вход"
  end

  def create
    @session = login(params[:email], params[:password], params[:remember_me])
    if @session
      redirect_to root_path, notice: 'Logged in!'
    else
      flash.now[:alert] = 'Email or password is invalid'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "Вы вышли из аккаунта!"
  end
end
