# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  firstname              :string           not null
#  lastname               :string           not null
#  email                  :string           default(""), not null
#  phone_number           :string
#  status                 :integer          default(0), not null
#  year                   :date             not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord

  has_many :works
  has_many :projects, through: :works
  has_many :workshops, through: :projects

  has_many :orals
  has_many :projects_orals, through: :orals, :source => "projects"
  validates :lastname, :firstname, :phone_number, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
