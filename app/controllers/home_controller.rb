class HomeController < ApplicationController
  def index
    @results = TestResult.where(user_id: current_user.id).order(created_at: :desc).limit(3)
    puts @results
    unless @results.nil?
      @tests = Test.all
    else
      @tests = []
      @results = []
    end
  end



  private

end
