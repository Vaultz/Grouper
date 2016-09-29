# == Schema Information
#
# Table name: works
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  project_id     :integer
#  project_leader :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class WorkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
