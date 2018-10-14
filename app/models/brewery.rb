class Brewery < ApplicationRecord

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { only_integer: true,
                                   greater_than: 1039,
                                   less_than_or_equal_to: ->(_) { Time.now.year } }

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil,false] }

  include RatingAverage

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2018
    puts "changed year to #{year}"
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating || 0) }
    return sorted_by_rating_in_desc_order.take(n)
  end

  def to_s
    name
  end
end
