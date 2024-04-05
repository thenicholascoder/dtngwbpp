class Like < ApplicationRecord
  belongs_to :liker, class_name: "User"
  belongs_to :liked, class_name: "User"

  validates :liker, presence: true
  validates :liked, presence: true
end
