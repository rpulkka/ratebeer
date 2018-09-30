require 'rails_helper'

include Helpers

describe "Beer" do
  it "when given, is registered to the beer and user who is signed in" do
    FactoryBot.create :brewery, name:"Koff"
    FactoryBot.create :user
    sign_in(username: "Pekka", password: "Foobar1")
    visit new_beer_path
    
    fill_in('beer[name]', with:'Bisse')
    select('Weizen', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')
    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "alert is shown and creation is aborted when beer is misnamed" do
    FactoryBot.create :brewery, name:"Koff"
    FactoryBot.create :user
    sign_in(username: "Pekka", password: "Foobar1")
    visit new_beer_path
    
    fill_in('beer[name]', with:'')
    select('Weizen', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')
    click_button "Create Beer"
    expect(Beer.count).to eq(0)
    expect(page).to have_content "Name is too short"
  end
end  
