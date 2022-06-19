require "test_helper"

class LongestWordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @longest_word = longest_words(:one)
  end

  test "should get index" do
    get longest_words_url, as: :json
    assert_response :success
  end

  test "should create longest_word" do
    assert_difference("LongestWord.count") do
      post longest_words_url, params: { longest_word: { answer: @longest_word.answer, answer_end: @longest_word.answer_end, answer_start: @longest_word.answer_start, player: @longest_word.player, result: @longest_word.result, score: @longest_word.score } }, as: :json
    end

    assert_response :created
  end

  test "should show longest_word" do
    get longest_word_url(@longest_word), as: :json
    assert_response :success
  end

  test "should update longest_word" do
    patch longest_word_url(@longest_word), params: { longest_word: { answer: @longest_word.answer, answer_end: @longest_word.answer_end, answer_start: @longest_word.answer_start, player: @longest_word.player, result: @longest_word.result, score: @longest_word.score } }, as: :json
    assert_response :success
  end

  test "should destroy longest_word" do
    assert_difference("LongestWord.count", -1) do
      delete longest_word_url(@longest_word), as: :json
    end

    assert_response :no_content
  end
end
