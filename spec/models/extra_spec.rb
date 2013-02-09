# == Schema Information
#
# Table name: extras
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  special_title :string(255)
#  experience    :integer
#  behance       :string(255)
#  deviantart    :string(255)
#  kongregate    :string(255)
#  gamasutra     :string(255)
#  newgrounds    :string(255)
#  gamejolt      :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Extra do
  pending "add some examples to (or delete) #{__FILE__}"
end
