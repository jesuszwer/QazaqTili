class QuestionsController < ApplicationController

  before_action :check_login, only: [:index, :show]

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

  def json
    test = Test.find(params[:id])
    questions = test.questions.includes(:options) # Загрузка вопросов и связанных с ними вариантов ответов
    json_response = []

    questions.each do |question|
      correct_option = question.options.find { |option| option.correct } # Находим правильный вариант ответа
      correct_option_content = correct_option.content if correct_option # Получаем контент правильного ответа, если он есть

      json_response << {
        id: question.id,
        content: question.content,
        correct_option_content: correct_option_content # Добавляем контент правильного ответа в JSON
      }
    end

    render json: json_response
  end




end
