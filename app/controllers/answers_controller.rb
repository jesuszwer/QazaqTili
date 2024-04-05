class AnswersController < ApplicationController

  require 'open-uri'

  before_action :check_login, only: [:index, :show, :create]

  def create
    json_data = request.body.read

    # Преобразовываем JSON строку в объект Ruby
    data_hash = JSON.parse(json_data)

    # Теперь снова преобразуем объект Ruby в JSON строку без экранирования спецсимволов
    json_data_without_slashes = data_hash.to_json

    answers = Answer.new()
    answers.user_id = current_user.id.to_i
    answers.test_id = request.headers["X-Test-ID"].to_i

    answers.answers_json = json_data_without_slashes
    true_answer_url = url_for(controller: 'questions', action: 'json', id: request.headers["X-Test-ID"].to_i, only_path: false)

    if answers.save
      true_answer_json = URI.open(true_answer_url).read
      answer_comparison(JSON.parse(answers.answers_json), JSON.parse(true_answer_json), request.headers["X-Test-ID"].to_i)
      render json: answers, status: :created
    else
      render json: { errors: answers.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    testsResult = TestResult.where(user_id: current_user.id)

    @tests = Test.where(id: testsResult.pluck(:test_id))

    @last_score = []

    testsResult.each do |tr|
      @last_score << tr.answers["answers"].last["total_score"].to_i
    end

    @page_title = "Результаты тестов"
  end

  def show
    user_id = params[:user_id]
    test_id = params[:test_id]

    # Изменение запроса к базе данных для выбора последнего результат теста
    testResult = TestResult.where(test_id: test_id, user_id: user_id).order(created_at: :desc).first
    @test = Test.find(test_id)

    if testResult.present?
        data = JSON.parse(testResult.answers)

        @answers = data["answers"]
        @total_true_answers = data["total_true_answers"].to_i
        @total_score = data["total_score"].to_i
        @letter_score = data["letter_score"].to_s
        # @letter_score = "E"
        @percent_score = data["total_score"].to_i
    else
        # Обработка случая, когда результат теста не найден
        @answers = []
        @total_true_answers = 0
        @total_score = 0
        @letter_score = ""
        @percent_score = 0
    end

    @page_title = "Итоги теста"
end

  private

  def answer_params
    params.require(:answers).permit(:answers_content)
  end

  # Проверка правильности ответа, принимает 2 json файла на вход и записывает в БД баллы в TestResults
  def answer_comparison(user_answer, true_answer, test_id)
    # Создаем запись в БД в TestResults
    testResult = TestResult.new
    testResult.user_id = current_user.id
    testResult.test_id = test_id

    results = { "questions_results": {} }
    total_true_answers = 0

    true_answer.each_with_index do |true_answer_item, index|
        user_answer_item = user_answer[index]

        if user_answer_item["question_answer"] == true_answer_item["correct_option_content"]
            results[:questions_results][index + 1] = 1
            total_true_answers += 1
        else
            results[:questions_results][index + 1] = 0
        end
    end

    results[:total_true_answers] = total_true_answers
    results[:percent_score] = ((total_true_answers.to_f / true_answer.length) * 100).to_i


    results[:total_score] = case results[:percent_score]
      when 90..100 then 5
      when 70..89 then 4
      when 50..69 then 3
      when 0..49 then 2
      else 0
    end

    results[:letter_score] = case results[:total_score]
      when 5 then "A"
      when 4 then "B"
      when 3 then "C"
      when 2 then "F"
    end


    testResult.answers = results.to_json
    testResult.save
    return
  end


end
