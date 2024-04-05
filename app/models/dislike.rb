class Dislike < ApplicationRecord
  belongs_to :disliker, class_name: "User"
  belongs_to :disliked, class_name: "User"

  validates :disliker, presence: true
  validates :disliked, presence: true
end
