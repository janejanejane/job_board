# == Schema Information
#
# Table name: jobs
#
#  id                  :integer         not null, primary key
#  jobtitle            :string(255)
#  category            :string(255)
#  location            :string(255)
#  description         :text
#  apply_details       :text
#  company_name        :string(255)
#  company_website     :string(255)
#  confirmation_email  :string(255)
#  salary              :decimal(10, 2)
#  jobtype             :string(255)
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  jobkey              :string(255)
#  jobkey_confirmation :string(255)
#  isdeleted           :integer
#

require 'spec_helper'

describe Job do
  
  before { @job = Job.new(jobtitle: "Ruby/Rails Developer",
                          category: "Programming",
                          location: "Makati",
                          description: "Large and profitable internet company launching brand new service built in Ruby/Rails. We care about creating great software and are willing to pay for talent. ",
                          apply_details: "Send resume to jeanclaudetteambait@gmail.com",
                          company_name: "JCSA",
                          company_website: "jeanambait.com",
                          confirmation_email: "jeanclaudetteambait@gmail.com",
                          salary: "25000".to_f,
                          jobtype: "Full-time",
                          jobkey: "9afd87bd05150323027a034c8bc10fd0ed1b32f4",
                          jobkey_confirmation: "9afd87bd05150323027a034c8bc10fd0ed1b32f4")}
                          
  subject { @job }
  
  it { should respond_to(:jobtitle) }
  it { should respond_to(:category) }
  it { should respond_to(:location) }
  it { should respond_to(:description) }
  it { should respond_to(:apply_details) }
  it { should respond_to(:company_name) }
  it { should respond_to(:company_website) }
  it { should respond_to(:confirmation_email) }
  it { should respond_to(:salary) }
  it { should respond_to(:jobtype) }
  it { should respond_to(:jobkey) }
  it { should respond_to(:jobkey_confirmation) }
  
  it { should be_valid }
  
  describe "when job title is not present" do
    before { @job.jobtitle = " " }
    it { should_not be_valid }
  end
  
  describe "when category is not present" do
    before { @job.category = " " }
    it { should_not be_valid }
  end
  
  describe "when location is not present" do
    before { @job.location = " " }
    it { should_not be_valid }
  end
  
  describe "when description is not present" do
    before { @job.description = " " }
    it { should_not be_valid }
  end
  
  describe "when company name is not present" do
    before { @job.company_name = " " }
    it { should_not be_valid }
  end
  
  describe "when company website is not present" do
    before { @job.company_website = " " }
    it { should_not be_valid }
  end
  
  describe "when confirmation email is not present" do
    before { @job.confirmation_email = " " }
    it { should_not be_valid }
  end
  
  describe "when job title is too long" do
    before { @job.jobtitle = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when location is too long" do
    before { @job.location = "a" * 101 }
    it { should_not be_valid }
  end
  
  describe "when company name is too long" do
    before { @job.company_name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when company website is invalid" do
    it "should be invalid" do
      urls = %w[http://invalid##host.com http://invalid,com host#com jean http://]
      urls.each do |invalid_url|
        @job.company_website = invalid_url
        @job.should_not be_valid
      end
    end
  end
  
  describe "when confirmation email is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @job.confirmation_email = invalid_address
        @job.should_not be_valid
      end
    end
  end
  
  describe "when company website is valid" do
    it "should be valid" do
      urls = %w[https://facebook.com http://www.google.com apple.com]
      urls.each do |valid_url|
        @job.company_website = valid_url
        @job.should be_valid
      end
    end
  end
  
  describe "when confirmation email is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @job.confirmation_email = valid_address
        @job.should be_valid
      end
    end
  end

  it "sends an email" do
    @job.confirmation
    ActionMailer::Base.deliveries.last.to.should == [@job.confirmation_email]
  end
end
