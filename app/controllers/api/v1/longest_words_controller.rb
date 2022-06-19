class Api::V1::LongestWordsController < ApplicationController
  before_action :set_longest_word, only: %i[show update destroy]

  def index
    @longest_words = LongestWord.all

    render json: @longest_words
  end

  def show
    render json: @longest_word
  end

  def create
    @longest_word = LongestWord.new(longest_word_params)

    if @longest_word.save
      render json: @longest_word, status: :created, location: @longest_word
    else
      render json: @longest_word.errors, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_longest_word
    @longest_word = LongestWord.find(params[:id])
  end
  # Only allow a list of trusted parameters through.
  def longest_word_params
    params.require(:longest_word).permit(:answer, :result, :player, :answer_start, :answer_end, :score)
  end
  def part_of_grid(input, letters)
    array_of_letters = input.upcase.chars
    array_of_letters.all? do |letter|
    return false unless letters.include?(letter)
      index = letters.find_index(letter)
      # binding.pry
      letters.delete_at(index)
    end
  end
  def score
    attempt = params[:input]
    attempt_serialized = URI.open("https://wagon-dictionary.herokuapp.com/#{attempt}").read
    attempt_json = JSON.parse(attempt_serialized)
    @result = {}
    # binding.pry
    if attempt_json['found'] && part_of_grid(attempt, $letters)
      @result[:score] = attempt.size * 50
      @result[:message] = "You got one here !"
    elsif part_of_grid(attempt, $letters) && !(attempt_json['found'])
      @result[:message] = "Your word is not english. Désolé."
      @result[:score] = 0
    else
      @result[:message] = "Some letters are not part of the grid !"
      @result[:score] = 0
    end
    # binding.pry
    return @result
  end
end
