module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    scorelist = ratings.map(&:score)
    sum = scorelist.reduce(:+)
    sum / ratings.count
  end
end
