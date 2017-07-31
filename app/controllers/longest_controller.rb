class LongestController < ApplicationController
  def game
    longest_word = LongestWord.new
    @grid = longest_word.generate_grid(9)
    @start_time = Time.now
  end

  def score
    @attempt = params[:attempt]
    @grid = JSON.parse(params[:grid])
    @start_time = Time.parse(params[:start_time])
    longest_word = LongestWord.new
    @end_time = Time.now
    @result = longest_word.run_game(@attempt, @grid, @start_time, @end_time)
  end

  def home
  end
end
