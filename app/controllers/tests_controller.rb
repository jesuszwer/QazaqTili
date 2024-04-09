class TestsController < ApplicationController
  before_action :check_login, only: [:new]
  def new
    @test = Test.new
    @questions = []
    @option = []
  end
end
