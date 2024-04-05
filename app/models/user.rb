class User < ApplicationRecord
  has_many :user_photos
  has_many :photos, through: :user_photo
  has_many :outgoing_likes, class_name: "Like", foreign_key: "liker_id", dependent: :destroy
  has_many :liked_users, through: :outgoing_likes, source: :liked
  has_many :incoming_likes, class_name: "Like", foreign_key: "liked_id", dependent: :destroy
  has_many :likers, through: :incoming_likes, source: :liker
  has_many :outgoing_dislikes, class_name: "Dislike", foreign_key: "disliker_id", dependent: :destroy
  has_many :disliked_users, through: :outgoing_dislikes, source: :disliked
  has_many :incoming_dislikes, class_name: "Dislike", foreign_key: "disliked_id", dependent: :destroy
  has_many :dislikers, through: :incoming_dislikes, source: :disliker
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  normalizes :email, with: ->(email) {email.strip.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :first_name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :mobile, presence: true, length: { minimum: 10, maximum: 15 }
  validates :email, presence: true, length: { minimum: 6, maximum: 254 },
              format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :country, presence: true, length: { minimum: 4, maximum: 56 }
  validates :state, presence: true, length: { maximum: 100 }
  validates :city, presence: true, length: { maximum: 100 }
  validates :birthdate, presence: true
  validates :gender, inclusion: { in: %w(Male Female) }, allow_blank: true
  validates :sexual_orientation, inclusion: { in: %w(Straight Gay Lesbian Bisexual) }, allow_blank: true
  validates :gender_interest, inclusion: { in: %w(Male Female) }, allow_blank: true
  validates :school, length: { maximum: 100 }
  validates :bio, length: { maximum: 1000 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  class << self
    # Returns the hash digest of the given string.
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
end
