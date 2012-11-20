namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_jobposts 
  end
end

def make_jobposts
  1.times do |n|
    jobtitle = "Android Engineer"
    category = "Programming"
    location = "Taguig"
    description = "We're looking for someone to help us build Android apps."
    apply_details = "Send resume to jeanclaudetteambait@gmail.com"
    company_name = "This Company"
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

  1.times do |n|
    jobtitle = "Digital Art Director"
    category = "Design"
    location = "Pasig"
    description = "The Digital Art Director is responsible for the idea, design and artistic direction of intelligent and engaging interactive experiences for a wide range of clients and platforms."
    apply_details = "Send resume to jeanclaudetteambait@gmail.com"
    company_name = "Aming Kumpanya"
    company_website = "http://jeanambait.com"
    confirmation_email = "jeanclaudetteambait@gmail.com"
    salary = "35000".to_f
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
    jobtitle = "Project Manager"
    category = "Business/Exec"
    location = "Boni"
    description = "We are an interactive studio with a relaxed but focused and hard-working culture."
    apply_details = "Send resume to jeanclaudetteambait@gmail.com"
    company_name = "The New Company"
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
end