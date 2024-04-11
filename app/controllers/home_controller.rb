class HomeController < ApplicationController
  def index
    @results = TestResult.where(user_id: current_user.id).order(created_at: :desc).limit(5)
    @tests = Test.where(id: @results.pluck(:test_id))



  end


  private

end
