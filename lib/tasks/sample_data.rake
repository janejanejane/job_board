namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_jobposts 
  end
end

def make_jobposts
  1.times do |n|
    jobtitle = "Ruby/Rails Developer"
    category = "Programming"
    location = "Makati"
    description = "Large and profitable internet company launching brand new service built in Ruby/Rails. We care about creating great software and are willing to pay for talent. "
    apply_details = "Send resume to jeanclaudetteambait@gmail.com"
    company_name = "JCSA"
    company_website = "http://jeanambait.com"
    confirmation_email = "jeanclaudetteambait@gmail.com"
    salary = "25000".to_f
    jobtype = "Full-time"
    jobkey = SecureRandom.hex(20)
    jobkey_confirmation = jobkey

    Job.create!(jobtitle: jobtitle,
                category: category,
                location: location,
                description: description,
                apply_details: apply_details,
                company_name: company_name,
                company_website: company_website,
                confirmation_email: confirmation_email,
                salary: salary,
                jobtype: jobtype,
                jobkey: jobkey,
                jobkey_confirmation: jobkey_confirmation)
  end
end