class User < ApplicationRecord
  include RatingAverage
  extend Top

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
    user.to_s
  end

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    fav_style = ""
    fav_avg = 0
    style_hash = ratings.group_by{ |r| r.beer.style }
    style_hash.each_value do |ratings|
      sum = 0
      ratings.each do |rating|
        sum += rating.score
      end
      avg = sum / ratings.size
      if avg > fav_avg
        fav_avg = avg
        fav_style = style_hash.key(ratings).name
      end
    end
    fav_style
  end

  def favorite_brewery
    return nil if ratings.empty?

    fav_brewery = ""
    fav_avg = 0
    style_hash = ratings.group_by{ |r| r.beer.brewery }
    style_hash.each_value do |ratings|
      sum = 0
      ratings.each do |rating|
        sum += rating.score
      end
      avg = sum / ratings.size
      if avg > fav_avg
        fav_avg = avg
        fav_brewery = style_hash.key(ratings)
      end
    end
    fav_brewery
  end
end
