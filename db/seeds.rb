# require 'date'


# result = %w[GGyouwon hoNoYoulost NotanEnglishWord]
# player = %w[Marie Bonnie Kinoshita Poupoul Marco Kiwi Marge Lopes]
# answer = %w[Cochon Mama Mimi Bobo Lolo]
# all_letters = Array('A'..'Z')

# 25.times do
#   grid = Array.new(10) { all_letters.sample }
#   LongestWord.create!(
#     result: result.sample,
#     player: player.sample,
#     time: rand(6000),
#     grid: grid,
#     score: rand(251),
#     answer: answer.sample
#   )
# end

# User.create!(
#   email: 'aa@bb.com',
#   password: 'qwertz12',
#   username: 'Doe'
# )

user = User.first

Post.create!(
  title: 'hey here is the first post',
  content: 'blablabawffw fewf few fw efe ewf wef ewfwewfewf ewfewfewffwf',
  user: user
)
