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

  validates :name, :description, :teacher, :begins, :ends, :teamgeneration, :projectleaders,:teamnumber, presence: true
  validates :teamnumber, numericality: { only_integer: true, :greater_than_or_equal_to => 1}
  # , :less_than_or_equal_to => User.where("status = 0 OR status = 1").count   // a vérifier
  validates_date :begins, :on_or_before => lambda { :ends }
  accepts_nested_attributes_for :projects

  # Method to define the params use when generating ral path
  def to_param
    {year: year, id: id}
  end

end
