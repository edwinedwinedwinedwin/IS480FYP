class ProjectMember < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :project
  belongs_to :user

  validates :user,presence: true
  validates :email1, :presence=>true
end
