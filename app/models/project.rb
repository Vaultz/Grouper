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
    has_one :workshop
    has_many :works, dependent: :destroy # Destroy associated works (link with users)
    belongs_to :workshop
    has_many :users, through: :works
    has_many :orals, dependent: :destroy # Destroy associated orals
    has_many :attendees, through: :orals, :source => :user
    validates :name, :description, :presence => true
end
