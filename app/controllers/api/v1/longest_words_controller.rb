require 'uri'
require 'net/http'
require 'json'

class Api::V1::LongestWordsController < ApplicationController
  before_action :set_longest_word, only: %i[show]

  def index
    @longest_words = LongestWord.all.reverse

    render json: @longest_words
  end

  def show
    render json: @longest_word
  end

  def new
    all_letters = Array('A'..'Z')
    grid = Array.new(10) { all_letters.sample }
    render json: grid
  end

  def create
    @longest_word = LongestWord.new(longest_word_params)
    result = score(longest_word_params["grid"],
                   longest_word_params["answer"],
                   longest_word_params["time"].is_a?(Numeric) ? longest_word_params["time"] : 60_000)
    @longest_word.result = result[:message]
    @longest_word.score = result[:score]
    if @longest_word.save
      render json: @longest_word, status: :created
    else
      render json: @longest_word.errors, status: :unprocessable_entity
    end
  end

  def top
    top_longest_words = LongestWord.order(score: :desc).limit(5)
    render json: top_longest_words
  end

  private

  def set_longest_word
    @longest_word = LongestWord.find(params[:id])
  end

  def longest_word_params
    params.require(:longest_word).permit(:answer, :player, :time, grid: [])
  end

  def score(grid, answer, time)
    time.round(0)
    answer.downcase!
    uri = URI("https://api.dictionaryapi.dev/api/v2/entries/en/#{answer}")
    response = Net::HTTP.get_response(uri)
    json_response = JSON.parse(response.body)[0]
    result = {}
    if response.is_a?(Net::HTTPSuccess) && part_of_grid(answer, grid)
      p time
      result[:score] = (answer.size * 40) + (60 - time / 1000)
      result[:message] = "You got one here !"
      result[:definition] = json_response["meanings"][0]["definitions"][0]["definition"]
    elsif !response.is_a?(Net::HTTPSuccess) && part_of_grid(answer, grid)
      result[:message] = "Your word is not english. Désolé."
      result[:score] = 1
    else
      result[:message] = "Some letters are not part of the grid !"
      result[:score] = 0
    end
    return result
  end

  def part_of_grid(input, grid)
    letters = grid.join()
    array_of_letters = input.upcase.chars
    array_of_letters.all? do |letter|
      return false unless letters.include?(letter)

      index = grid.find_index(letter)
      grid.delete_at(index)
    end
  end
end
