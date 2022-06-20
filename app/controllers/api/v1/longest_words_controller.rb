require 'open-uri'
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
    # p longest_word_params["grid"]
    # p longest_word_params
    @longest_word = LongestWord.new(longest_word_params)
    result = score(longest_word_params["grid"], longest_word_params["answer"], longest_word_params["time"])
    @longest_word.result = result[:message]
    @longest_word.score = result[:score]
    if @longest_word.save
      render json: @longest_word, status: :created
    else
      render json: @longest_word.errors, status: :unprocessable_entity
    end
  end

  private

  def set_longest_word
    @longest_word = LongestWord.find(params[:id])
  end

  def longest_word_params
    params.require(:longest_word).permit(:answer, :player, :time, grid: [])
  end

  def score(grid, answer, time)
    answer_serialized = URI.open("https://wagon-dictionary.herokuapp.com/#{answer}").read
    answer_json = JSON.parse(answer_serialized)
    result = {}
    if answer_json['found'] && part_of_grid(answer, grid)
      result[:score] = answer.size * 50 + time / 1000
      result[:message] = "You got one here !"
    elsif part_of_grid(answer, grid) && !(answer_json['found'])
      result[:message] = "Your word is not english. Désolé."
      result[:score] = 0
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
