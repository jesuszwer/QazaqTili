class UsersController < ApplicationController
  before_action :check_login, only: [:edit, :update, :index]
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
    @page_title = "Профиль"
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(edit_user_params)
      redirect_to profile_path, notice: 'Данные изменены!'
    else
      flash.now[:alert] = 'Ошибка при изминении данных профиля!'
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def edit_user_params
    params.require(:user).permit(:avatar, :name, :last_name)
  end
  def user_params
    params.require(:user).permit(:email, :name, :last_name, :password, :password_confirmation)
  end
end
