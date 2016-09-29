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

class Work < ApplicationRecord

    belongs_to :user
    belongs_to :project

end
