namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_jobposts 
  end
end

def make_jobposts
  1.times do |n|
    jobtitle = "Dev Ops Engineer"
    category = "Programming"
    location = "Makati"
    description = "We are looking for someone who can support our current LAMP application infrastructure and work closely with the development team and other support resources."
    apply_details = "Send resume to jeanclaudetteambait@gmail.com"
    company_name = "Old Company"
    company_website = "http://jeanambait.com"
    confirmation_email = "jeanclaudetteambait@gmail.com"
    salary = "50000".to_f
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
    jobtitle = "Dot Net Architect"
    category = "Programming"
    location = "Shaw"
    description = "We assist companies to develop Cloud based applications using our tool set, migrate those to the Cloud, and manage these applications on customized public or private cloud platforms."
    apply_details = "Send resume to jeanclaudetteambait@gmail.com"
    company_name = "Ang Bagong Company"
    company_website = "http://jeanambait.com"
    confirmation_email = "jeanclaudetteambait@gmail.com"
    salary = "60000".to_f
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
    jobtitle = "WordPress Software Engineer"
    category = "Programming"
    location = "Manila"
    description = "Our clients vary from startups to Fortune 500 companies. This is a full-time position at our Chicago office."
    apply_details = "Send resume to jeanclaudetteambait@gmail.com"
    company_name = "We Company"
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

  1.times do |n|
    jobtitle = "Jr. Flash Developer"
    category = "Design"
    location = "Ortigas"
    description = "This is an entry-level position."
    apply_details = "Send resume to jeanclaudetteambait@gmail.com"
    company_name = "Small Kumpanya"
    company_website = "http://jeanambait.com"
    confirmation_email = "jeanclaudetteambait@gmail.com"
    salary = "15000".to_f
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
    jobtitle = "iOS Engineer"
    category = "iPhone Developer"
    location = "Bonifacio Global City"
    description = "We're looking for an iOS developer to help us empower mobile workforces. "
    apply_details = "Send resume to jeanclaudetteambait@gmail.com"
    company_name = "Rich Company"
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
end