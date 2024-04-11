class ResultsController < ApplicationController
  def create
    json_date = request.body.read

    test_result = TestResult.new
    test_result.user_id = current_user.id
    test_result.test_id = request.headers["X-Test-ID"].to_i

    test_result.answers = json_date

    if test_result.save
      render json: test_result, status: :created
    else
      render json: { errors: test_result.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
