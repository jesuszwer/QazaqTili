class UsersController < ApplicationController
  def new
    @page_title = "Регистрация"
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: 'Пользователь успешно зарегистрирован!'
    else
      flash.now[:alert] = 'Ошибка регистрации пользователя'
      render :new, status: :unprocessable_entity
    end
  end

  def index
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
