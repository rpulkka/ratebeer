class User < ApplicationRecord
  include RatingAverage

  PASSWORD_FORMAT = /\A
    (?=.*\d)
    (?=.*[A-Z])
    /x

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 },
                       format: { with: PASSWORD_FORMAT }
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships
  has_secure_password

  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.count.to_f
  end

  def to_s
    "#{username}"
  end
end
