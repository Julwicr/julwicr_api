class LongestWordsController < ApplicationController
  before_action :set_longest_word, only: %i[ show update destroy ]

  # GET /longest_words
  def index
    @longest_words = LongestWord.all

    render json: @longest_words
  end

  # GET /longest_words/1
  def show
    render json: @longest_word
  end

  # POST /longest_words
  def create
    @longest_word = LongestWord.new(longest_word_params)

    if @longest_word.save
      render json: @longest_word, status: :created, location: @longest_word
    else
      render json: @longest_word.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /longest_words/1
  def update
    if @longest_word.update(longest_word_params)
      render json: @longest_word
    else
      render json: @longest_word.errors, status: :unprocessable_entity
    end
  end

  # DELETE /longest_words/1
  def destroy
    @longest_word.destroy
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
end
