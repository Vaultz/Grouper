# == Schema Information
#
# Table name: workshops
#
#  id             :integer          not null, primary key
#  name           :string
#  description    :text
#  user_id        :integer
#  teacher        :string
#  begins         :date
#  ends           :date
#  teamgeneration :integer
#  teamnumber     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Workshop < ApplicationRecord

  has_many :projects, dependent: :destroy # Destroy associated projects
  belongs_to :user

  validates :name, :teacher, :begins, :ends, :teamgeneration, :teamnumber , presence: true

end
