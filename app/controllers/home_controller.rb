class HomeController < ApplicationController
  def index
    @welcome_check = false
    check_first_visit
    @page_title = "Главное"
  end


  private

  def check_first_visit
    unless session[:visited]
      session[:visited] = true
      @welcome_check = true
    end
  end

end
