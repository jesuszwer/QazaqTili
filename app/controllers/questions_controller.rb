class QuestionsController < ApplicationController
  def index
    @page_title = "Тесты"
    @tests = Test.all
    @questions = Question.all
  end

  def show
    @test = Test.find(params[:id])
    @page_title = "Тестирование"
    @questions = Question.all
  end
end
