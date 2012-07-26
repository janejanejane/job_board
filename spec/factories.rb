FactoryGirl.define do
  factory :job do
    jobtitle "Ruby/Rails Developer"
    category "Programming"
    location "Makati"
    description "Large and profitable internet company launching brand new service built in Ruby/Rails. We care about creating great software and are willing to pay for talent. "
    apply_details "Send resume to jeanclaudetteambait@gmail.com"
    company_name "JCSA"
    company_website "jeanambait.com"
    confirmation_email "jeanclaudetteambait@gmail.com"
    salary "25000".to_f
    jobtype "Full-time"
  end
end