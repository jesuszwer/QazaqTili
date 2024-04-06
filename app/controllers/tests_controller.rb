class TestsController < ApplicationController
  def new
    @test = Test.new
    @questions = []
    @option = []
  end
end
