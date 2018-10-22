require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :selenium do |app|
      capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: ['headless', 'disable-gpu']  }
    )

    Capybara::Selenium::Driver.new app,
      browser: :chrome,
      desired_capabilities: capabilities      
    end
    WebMock.disable_net_connect!(allow_localhost: true) 
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name:"Koff")
    @brewery2 = FactoryBot.create(:brewery, name:"Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name:"Ayinger")
    @style1 = Style.create name:"Lager"
    @style2 = Style.create name:"Rauchbier"
    @style3 = Style.create name:"Weizen"
    @beer1 = FactoryBot.create(:beer, name:"Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name:"Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name:"Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows one known beer", js:true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    expect(page).to have_content "Nikolai"
  end

  it "sorts by name", js:true do
    visit beerlist_path
    
    row1 = find('table').find('tr:nth-child(2)')
    row2 = find('table').find('tr:nth-child(3)')
    row3 = find('table').find('tr:nth-child(4)')

    expect(row1).to have_content "Fastenbier"
    expect(row2).to have_content "Lechte Weisse"
    expect(row3).to have_content "Nikolai"
  end

  it "sorts by brewery name", js:true do
    visit beerlist_path

    page.find(:css, "#brewery").click()

    row1 = find('table').find('tr:nth-child(2)')
    row2 = find('table').find('tr:nth-child(3)')
    row3 = find('table').find('tr:nth-child(4)')

    expect(row1).to have_content "Lechte Weisse"
    expect(row2).to have_content "Nikolai"
    expect(row3).to have_content "Fastenbier"
  end

  it "sorts by style name", js:true do
    visit beerlist_path

    page.find(:css, "#style").click()

    row1 = find('table').find('tr:nth-child(2)')
    row2 = find('table').find('tr:nth-child(3)')
    row3 = find('table').find('tr:nth-child(4)')

    expect(row1).to have_content "Nikolai"
    expect(row2).to have_content "Fastenbier"
    expect(row3).to have_content "Lechte Weisse"
  end
end