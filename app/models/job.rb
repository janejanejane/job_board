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

#require 'uri'

class Job < ActiveRecord::Base
  def self.confirmed
    where("jobkey_confirmation IS NOT NULL AND  isdeleted = 0").order("created_at DESC")
  end

  def self.expiring
    where("jobkey_confirmation IS NOT NULL AND
      created_at < CURRENT_DATE - INTERVAL '1 month' AND  isdeleted = 0").order("created_at DESC")
  end

  attr_accessible :apply_details, :category, :company_name, 
                  :company_website, :confirmation_email, :description, 
                  :jobtitle, :jobtype, :location, :salary, 
                  :jobkey, :jobkey_confirmation
                  
  validates :jobtitle, presence: :true, length: { maximum: 30 }
  validates :category, presence: :true
  validates :location, presence: :true, length: { maximum: 100 }
  validates :description, presence: :true
  validates :company_name, presence: :true, length: { maximum: 50 }
  #VALID_URL_REGEX = /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.?[a-z0-9]{2,5}\Z/ix
  #VALID_URL_REGEX = /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?/ix
  VALID_URL_REGEX = /\A(https?|ftp|file):\/\/[-A-Za-z0-9+&@#\/%?=~_|!:,.;]*[-A-Za-z0-9+&@#\/%=~_|]/ix
  validates :company_website, presence: :true, format: { with: VALID_URL_REGEX }
  #validates :company_website, presence: :true, format: { with: URI::regexp(%w(http https)) }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :confirmation_email, presence: :true, format: { with: VALID_EMAIL_REGEX }
  validates :salary, numericality: {greater_than: 0}
  validates :jobtype, presence: true
  validates :jobkey, presence: true

  before_create :set_isdeleted

  private
    def set_isdeleted
      self.isdeleted = 0
    end
end
