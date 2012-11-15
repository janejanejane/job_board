namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_jobposts 
  end
end

def make_jobposts
  1.times do |n|
    jobtitle = "Senior Web Developer"
    category = "Programming"
    location = "Ortigas"
    description = "Join a cool company that highly values your awesome skills."
    apply_details = "Send resume to jeanclaudetteambait@gmail.com"
    company_name = "My Company"
    company_website = "http://jeanambait.com"
    confirmation_email = "jeanclaudetteambait@gmail.com"
    salary = "45000".to_f
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

  1.times do |n|
    jobtitle = "Interactive Graphic Designer"
    category = "Design"
    location = "QC"
    description = "We are looking for an enthusiastic Interactive Graphic Designer to work in our fast-paced environment and generate a wide array of digital graphic elements."
    apply_details = "Send resume to jeanclaudetteambait@gmail.com"
    company_name = "Our Company"
    company_website = "http://jeanambait.com"
    confirmation_email = "jeanclaudetteambait@gmail.com"
    salary = "20000".to_f
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