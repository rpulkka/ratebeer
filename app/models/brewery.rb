class Brewery < ApplicationRecord
  include RatingAverage

  validates :name, length: { minimum: 1 }

  validates :year, numericality: { greater_than_or_equal_to: 1040,
                   less_than_or_equal_to: 2018,
                   only_integer: true }

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2018
    puts "changed year to #{year}"
  end

  def to_s
    name
  end
end
