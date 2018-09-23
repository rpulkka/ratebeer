class BeerClub < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  def to_s
    beer_club.to_s
  end
end
