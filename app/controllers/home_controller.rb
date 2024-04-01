class HomeController < ApplicationController
  def index
    @page_title = "Главное"
    @question = Question.find(1)
  end
end
