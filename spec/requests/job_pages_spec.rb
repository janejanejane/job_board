require 'spec_helper'
#include ActionView::Helpers::NumberHelper
#include ApplicationHelper

describe "JobPages" do
   subject { page }
   
  #describe "signup page" do
  #  before { visit signup_path }
    
  #  it { should have_selector('h1', text: 'Sign up') }
  #  it { should have_selector('title', text: full_title('Sign up'))}
  #end
  
  describe "jobs page" do
    let(:job) { FactoryGirl.create(:job) }
    before { visit job_path(job) }
    
    it { should have_selector('h1', text: job.jobtitle) }
    it { should have_selector('title', text: job.jobtitle) }
    it { should have_selector('h2', text: job.company_name) }
    #it { should have_selector('h3', text: php_salary(job.salary.to_s)) }
    it { should have_selector('h3', text: job.jobtype) }
    it { should have_selector('div', text:job.description) }
    it { should have_selector('div', text: job.apply_details) }
  end
  
  describe "add job page" do
    before { visit new_job_path }
    
    let(:submit) { "Add job" }
    
    describe "with invalid information" do
      it "should not create a job post" do
        expect { click_button submit }.not_to change(Job, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Job Title", with: "Ruby/Rails Developer"
        fill_in "Category", with: "Programming"
        fill_in "Location", with: "Makati"
        fill_in "Description", with: "Large and profitable internet company launching brand new service built in Ruby/Rails. We care about creating great software and are willing to pay for talent. "
        fill_in "Apply details", with: "Send resume to jeanclaudetteambait@gmail.com"
        fill_in "Company name", with: "JCSA"
        fill_in "Company website", with: "jeanambait.com"
        fill_in "Confirmation email", with: "jeanclaudetteambait@gmail.com"
        fill_in "Salary", with: "25000".to_f
        fill_in "Job Type", with: "Full-time"
      end
      
      it "should create a job post" do
        expect { click_button submit }.to change(Job, :count).by(1)
      end
    end
  end
end
