# == Schema Information
#
# Table name: votes
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  job_preference :integer
#  user_voted     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Vote do
  pending "add some examples to (or delete) #{__FILE__}"
end
