require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "favourite beer style and favourite brewery are shown" do
    FactoryBot.create :brewery, name:"Koff"
    FactoryBot.create :brewery, name:"Hartwall"
    FactoryBot.create :beer, name:"Karhu", brewery_id:1
    FactoryBot.create :beer, name:"Lappari", brewery_id:2
    FactoryBot.create :beer, name:"Random", style:"Bisse", brewery_id:1
    FactoryBot.create :rating, score:10, beer_id:1, user_id:1
    FactoryBot.create :rating, score:35, beer_id:2, user_id:1
    FactoryBot.create :rating, score:40, beer_id:3, user_id:1
    visit user_path(1)

    expect(page).to have_content 'Bisse'
    expect(page).to have_content 'Hartwall'
  end
end
