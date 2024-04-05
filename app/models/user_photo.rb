class UserPhoto < ApplicationRecord
  belongs_to :user
  belongs_to :photo, dependent: :destroy

  validate :validate_user_photo_limit, on: :create

  private

  def validate_user_photo_limit
    if user.user_photos.count >= 5
      errors.add(:base, "User can only have maximum of 5 photos")
    end
  end
end
