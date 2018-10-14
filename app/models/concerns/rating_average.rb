module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return 0 if ratings.empty?

    scorelist = ratings.map(&:score)
    sum = scorelist.reduce(:+)
    sum / ratings.count
  end
end
