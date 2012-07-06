require 'spec_helper'

describe "StaticPages" do
  
  describe "Home Page" do
    it "should have the h1 'Job Board'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => 'Job Board')
    end
    
    it "should have the title 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "IGDA Job Board | Home")
    end
  end
  
  describe "Help Page" do
    it "should have the h1 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', :text => 'Help')
    end
    
    it "should have the title 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title', :text => "IGDA Job Board | Help")
    end
  end
  
end
