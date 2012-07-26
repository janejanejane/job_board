# == Schema Information
#
# Table name: jobs
#
#  id                 :integer         not null, primary key
#  jobtitle           :string(255)
#  category           :string(255)
#  location           :string(255)
#  description        :text
#  apply_details      :text
#  company_name       :string(255)
#  company_website    :string(255)
#  confirmation_email :string(255)
#  salary             :decimal(10, 2)
#  jobtype            :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

require 'uri'

class Job < ActiveRecord::Base
  attr_accessible :apply_details, :category, :company_name, 
                  :company_website, :confirmation_email, :description, 
                  :jobtitle, :jobtype, :location, :salary
                  
  validates :jobtitle, presence: :true, length: { maximum: 30 }
  validates :category, presence: :true
  validates :location, presence: :true, length: { maximum: 100 }
  validates :description, presence: :true
  validates :company_name, presence: :true, length: { maximum: 50 }
  #VALID_URL_REGEX = /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.?[a-z0-9]{2,5}\Z/ix
  VALID_URL_REGEX = /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?/ix
  validates :company_website, presence: :true, format: { with: VALID_URL_REGEX }
  #validates :company_website, presence: :true, format: { with: URI::regexp(%w(http https)) }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :confirmation_email, presence: :true, format: { with: VALID_EMAIL_REGEX }
  validates :jobtype, presence: true
end
