class Post < ApplicationRecord
  belongs_to :user
  validates :title, :content, :user, presence: true
  validates :title, length: { in: 5..50 }
  validates :content, length: { in: 20..500 }

end
