class AnswersController < ApplicationController

  before_action :check_login, only: [:index, :show, :create]

  def create # POST запрос на создание ответа от пользователя
    json_data = request.body.read

    answer = Answer.new()
    answer.user_id = current_user.id.to_i
    answer.test_id = request.headers["X-Test-ID"].to_i

    answer.answers_json = json_data

    if answer.save
      render json: answer, status: :created, notice: "Ответ сохранен"
    else
      # answer_comparison(answer.answers_json, )
      render json: { errors: answers.errors.full_messages }, alert: "Ошибка при сохранении резульатов, попробуйте ещё раз", status: :unprocessable_entity
    end
  end

  def index
    testsResult = TestResult.where(user_id: current_user.id)
    @tests = Test.where(id: testsResult.pluck(:test_id))
  end

  def show
    # Изменение запроса к базе данных для выбора последнего результат теста
    @testResult = TestResult.where(test_id: params[:id], user_id: current_user.id).order(created_at: :desc).first
    @test = Test.find(params[:test_id])

    @page_title = "Итоги теста"
end

  private






















  # Проверка правильности ответа, принимает 2 json файла на вход и записывает в БД баллы в TestResults
  # def answer_comparison(user_answer, true_answer, test_id) # Проверка правильности ответов
  #   # Создаем запись в БД в TestResults
  #   testResult = TestResult.new
  #   testResult.user_id = current_user.id
  #   testResult.test_id = test_id

  #   results = { "questions_results": {} }
  #   total_true_answers = 0

  #   true_answer.each_with_index do |true_answer_item, index|
  #       user_answer_item = user_answer[index]

  #       if user_answer_item["question_answer"] == true_answer_item["correct_option_content"]
  #           results[:questions_results][index + 1] = 1
  #           total_true_answers += 1
  #       else
  #           results[:questions_results][index + 1] = 0
  #       end
  #   end

  #   results[:total_true_answers] = total_true_answers
  #   results[:percent_score] = ((total_true_answers.to_f / true_answer.length) * 100).to_i


  #   results[:total_score] = case results[:percent_score]
  #     when 90..100 then 5
  #     when 70..89 then 4
  #     when 50..69 then 3
  #     when 0..49 then 2
  #     else 0
  #   end

  #   results[:letter_score] = case results[:total_score]
  #     when 5 then "A"
  #     when 4 then "B"
  #     when 3 then "C"
  #     when 2 then "F"
  #   end


  #   testResult.answers = results.to_json
  #   testResult.save
  #   return
  # end


end
