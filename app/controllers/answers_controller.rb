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

    testResult = TestResult.find_by(test_id: test_id, user_id: user_id)
    @test = Test.find(test_id)

    data = JSON.parse(testResult.answers)

    @answers = data["answers"]

    @total_true_answers = data["total_true_answers"].to_i
    @total_score = data["total_score"].to_i
    @letter_score = data["letter_score"].to_s
    # @letter_score = "E"
    @percent_score = data["total_score"].to_i

    @page_title = "Итоги теста"
  end

  private

  def answer_params
    params.require(:answers).permit(:answers_content)
  end

  def check_login
    redirect_to login_path unless logged_in?
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
    results[:total_score] = (total_true_answers.to_f / true_answer.length * 5).clamp(2, 5)

    results[:letter_score] = case results[:total_score]
    when 5 then "A"
    when 4 then "B"
    when 3 then "C"
    when 2 then "D"
    end

    results[:percent_score] = ((results[:total_score].to_f / 5) * 100).to_i

    testResult.answers = results.to_json
    testResult.save
    return
  end


end
