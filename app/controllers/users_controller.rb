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
    @page_title = "Профиль"
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(edit_user_params)
      redirect_to profile_path, notice: 'Аватарка обновлена!'
    else
      flash.now[:alert] = 'Ошибка при загрузке аватарки'
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def edit_user_params
    params.require(:user).permit(:avatar)
  end
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
