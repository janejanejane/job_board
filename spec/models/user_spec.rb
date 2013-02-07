# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  first_name         :string(255)
#  last_name          :string(255)
#  nickname           :string(255)
#  personal_statement :string(140)
#  image              :string(255)
#  location           :string(255)
#  job_preference     :string(255)
#  availability       :integer
#  new_user           :boolean          default(TRUE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
