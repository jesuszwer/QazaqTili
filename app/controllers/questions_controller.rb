class QuestionsController < ApplicationController

  require "json"

  before_action :check_login, only: [:index, :show]

  def index
    @page_title = "Тесты"
    @tests = Test.all
  end

  def show
    @test = Test.find(params[:id])
    @json_date = @test.json_contents

    @page_title = "Тестирование"
  end

end
