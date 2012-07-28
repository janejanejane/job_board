require 'spec_helper'

describe "JobPages" do
  subject { page }
   
  #describe "signup page" do
  #  before { visit signup_path }
    
  #  it { should have_selector('h1', text: 'Sign up') }
  #  it { should have_selector('title', text: full_title('Sign up'))}
  #end
  
  describe "visit a job page" do
    let(:job) { FactoryGirl.create(:job) }
    before { visit job_path(job) }

    it { should have_selector('p.all-jobs', text: "<< Back to all jobs")}
    it { should have_selector('p.category-job', text: "See more #{job.category} jobs >>")}
    
    it { should have_selector('h1', text: job.jobtitle) }
    it { should have_selector('title', text: job.jobtitle) }
    it { should have_selector('h2', text: job.company_name) }
    it { should have_selector('span', text: "Posted " + format_date(job.created_at)) }
    it { should have_selector('span', text: "Location:" + job.location) }
    it { should have_selector('a', text: job.company_website) }
    it { should have_selector('h3', text: php_salary(job.salary.to_s)) }
    it { should have_selector('h3', text: job.jobtype) }
    it { should have_selector('div', text:job.description) }
    it { should have_selector('div', text: job.apply_details) }
  end

  describe "visit job index" do
    before do
      FactoryGirl.create(:job, jobtitle: "Ruby/Rails Developer",
                          category: "Programming",
                          location: "Makati",
                          description: "Large and profitable internet company launching brand new service built in Ruby/Rails. We care about creating great software and are willing to pay for talent. ",
                          apply_details: "Send resume to jeanclaudetteambait@gmail.com",
                          company_name: "JCSA",
                          company_website: "jeanambait.com",
                          confirmation_email: "jeanclaudetteambait@gmail.com",
                          salary: "25000".to_f,
                          jobtype: "Full-time")

      FactoryGirl.create(:job, jobtitle: ".NET Developer",
                          category: "Programming",
                          location: "Makati",
                          description: "Company launching brand new service built in .NET.",
                          apply_details: "Send resume to jeanambait@gmail.com",
                          company_name: "Jean Company",
                          company_website: "rails.com",
                          confirmation_email: "jeanambait@gmail.com",
                          salary: "25000".to_f,
                          jobtype: "Full-time")
      FactoryGirl.create(:job, jobtitle: "User Interface Developer",
                          category: "Design",
                          location: "Pasig",
                          description: "Company developing a web platform that offers an unprecedented real-world business education.",
                          apply_details: "Send resume to jeanambait@gmail.com",
                          company_name: "Jean Company",
                          company_website: "rails.com",
                          confirmation_email: "jeanambait@gmail.com",
                          salary: "30000".to_f,
                          jobtype: "Full-time")

      visit jobs_path
    end

    it { should have_selector('title', text: 'Job Board')}
    it { should have_selector('h1', text: 'All Jobs')}
    it { should have_link('Add job now!')}

    describe "job list" do
      let(:grouped_jobs) { Job.find(:all).group_by { |job| job.category } }

      it "should have category" do
        grouped_jobs.each do |category, jobs|
          should have_selector('h2', text: category)
          
          #describe "should list each job" do
            #jobs.each do |job|
              #it { should have_selector('span', text: job.location) }
              #it { should have_selector('span', text: job.jobtitle) }
              #it { should have_selector('span', text: job.company_name) }
              #it { should have_selector('span', text: format_date(job.created_at)) }
            #end
          #end
        end
      end
    end
  end
  
  describe "add job page" do
    before { visit new_job_path }
    
    let(:submit) { "Add job" }
    
    describe "with invalid information" do
      it "should not create a job post" do
        expect { click_button submit }.not_to change(Job, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_content('error') }
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Job Title", with: "Ruby/Rails Developer"
        #fill_in "Category", with: "Programming"
        choose("Programming")
        fill_in "Location", with: "Makati"
        fill_in "Description", with: "Large and profitable internet company launching brand new service built in Ruby/Rails. We care about creating great software and are willing to pay for talent. "
        fill_in "Apply details", with: "Send resume to jeanclaudetteambait@gmail.com"
        fill_in "Company name", with: "JCSA"
        fill_in "Company website", with: "jeanambait.com"
        fill_in "Confirmation email", with: "jeanclaudetteambait@gmail.com"
        fill_in "Salary", with: "25000".to_f
        #fill_in "Job Type", with: "Full-time"
        choose("Full-time")
      end
      
      it "should create a job post" do
        expect { click_button submit }.to change(Job, :count).by(1)
      end

      describe "after saving the job" do
        before { click_button submit }

        it { should have_selector('div.alert.alert-success')}
      end
    end
  end
end
