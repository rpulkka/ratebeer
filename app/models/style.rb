class Style < ApplicationRecord
  include RatingAverage
  extend Top

  has_many :beers
  has_many :ratings, through: :beers
end

def to_s
  "#{name}"
end
