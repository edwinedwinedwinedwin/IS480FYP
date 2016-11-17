class UserExpertise < ActiveRecord::Base
  belongs_to :user

  validates :expertise_name, :presence => true
  validates :user_id, :presence => true
end
