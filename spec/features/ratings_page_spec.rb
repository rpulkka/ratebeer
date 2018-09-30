require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryBot.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "are shown correctly" do
    FactoryBot.create :rating, score:10, beer_id:1, user_id:1
    FactoryBot.create :rating, score:15, beer_id:2, user_id:1
    visit ratings_path

    expect(page).to have_content "Total amount of ratings: 2"
    expect(page).to have_content "iso 3"
    expect(page).to have_content "Karhu"
  end  

  it "are shown in rater's page" do
    FactoryBot.create :user, username: "Random"
    FactoryBot.create :rating, score:10, beer_id:1, user_id:1
    FactoryBot.create :rating, score:15, beer_id:2, user_id:2
    visit user_path(user)

    expect(page).to have_content "iso 3"
    expect(page).to_not have_content "Karhu"
  end

  it "beer is deleted from rater's page" do
    FactoryBot.create :rating, score:10, beer_id:1, user_id:1
    FactoryBot.create :rating, score:15, beer_id:2, user_id:1
    visit user_path(user)

    expect{
      within("li:first-child") do
        click_link "delete"
      end  
    }.to change{Rating.count}.from(2).to(1)
  end  
end
