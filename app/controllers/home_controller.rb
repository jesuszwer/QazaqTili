class HomeController < ApplicationController
  def index
    @tests = Test.all

    unless TestResult.where(user_id: current_user.id).count == 0
      @results = TestResult.where(user_id: current_user.id).order(created_at: :desc).limit(3)
    else
      @results = []
    end

  end



  private

end
