class HomeController < ApplicationController
  def index
    @results = TestResult.where(user_id: current_user.id).order(created_at: :desc).limit(3) if current_user.present?
    @tests = Test.all

  end



  private

end
