require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved with correct arguments" do
    brewery = Brewery.create name: "BrewDogg", year: 1998 
    beer = Beer.create name:"Bisse", style:"Lager", brewery_id: 1

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without name" do
    brewery = Brewery.create name: "BrewDogg", year: 1998 
    beer = Beer.create style:"Lager", brewery_id: 1

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without style" do
    brewery = Brewery.create name: "BrewDogg", year: 1998 
    beer = Beer.create name:"", style:"Lager", brewery_id: 1

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
