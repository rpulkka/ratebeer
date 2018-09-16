module RatingAverage
    extend ActiveSupport::Concern
   
    def average_rating
        scorelist = (self.ratings).map{|i| i.score}
        sum = (scorelist).reduce(:+)
        return sum/self.ratings.count
    end 
end