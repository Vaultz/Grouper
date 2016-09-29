# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  workshop_id :integer
#

class Project < ApplicationRecord

    has_many :works
    belongs_to :workshop
    has_many :users, through: :works

end
