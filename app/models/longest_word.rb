class LongestWord < ApplicationRecord
  validates :player, presence: true, length: { minimum: 3 }
  validates :answer, presence: true, length: { maximum: 10 }
  validates_format_of :player, :answer, { with: /\A[a-zA-Z]+\z/, message: 'only letters allowed.' }
  validates :time, numericality: { only_integer: true }
end
