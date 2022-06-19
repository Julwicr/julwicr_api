
require 'date'


result = %w[GGyouwon hoNoYoulost NotanEnglishWord]
player = %w[Marie Bonnie Kinoshita Poupoul Marco Kiwi Marge Lopes]
answer = %w[Cochon Mama Mimi Bobo Lolo]

25.times do
  LongestWord.create!(
    result: result.sample,
    player: player.sample,
    answer_start: Date.new,
    answer_end: Date.new,
    score: rand(251),
    answer: answer.sample
  )
end
