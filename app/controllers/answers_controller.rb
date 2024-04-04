class AnswersController < ApplicationController

  before_action :check_login, only: [:index, :show, :create]
  before_action :set_test, only: [:create]

  def create
    @answers = Answer.new(answer_params)
    @answers.user = current_user
    @answers.test = @test

    if @answers.save
      render json: @answer, status: :created
    else
      render json: @answer.errors, status: :unprocessable_entity
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

    testResult = TestResult.find_by(user_id: user_id, test_id: test_id)
    @test = Test.find(test_id)
    @answers = testResult.answers["answers"]

    @total_true_answers = testResult.answers["total_true_answers"].to_i
    @total_score = testResult.answers["total_score"].to_i
    @letter_score = testResult.answers["letter_score"].to_s
    # @letter_score = "E"
    @percent_score = testResult.answers["total_score"].to_i

    @page_title = "Итоги теста"
  end

  private

  def set_test
    @test = Test.find(params[:test_id])
  end

  def answer_params
    params.require(:answers).permit(:answers_content)
  end

  def check_login
    redirect_to login_path unless logged_in?
  end

end
