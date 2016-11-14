class ProjectCategory < ActiveRecord::Base
  include ActiveModel::Validations

  has_many :projects
end
