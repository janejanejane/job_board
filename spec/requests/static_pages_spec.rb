require 'spec_helper'

describe "StaticPages" do
  subject { page }
  
  describe "Home Page" do
      before { visit root_path }
      
      it { should have_selector('h1', text: 'Job Board') }
      it { should have_selector('title', text: full_title('')) }
      it { should_not have_selector('title', text: '| Home') }
  end
  
  describe "Help Page" do
      before { visit help_path }
      
      it { should have_selector('h1', text: 'Help') }
      it { should have_selector('title', text: full_title('Help')) }
  end
  
end
