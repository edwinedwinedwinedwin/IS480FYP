class User < ActiveRecord::Base
  include ActiveModel::Validations

  has_many :projects
  has_many :project_members
  has_many :user_expertises

  mount_uploader :profile_pic, ProfilePicUploader
  validates_file_size :profile_pic, less_than: 5.megabytes
  has_secure_password # use bcrypt methods to generate password digest = no password is stored in DB; only password digest stored.

  validates_uniqueness_of :email, client_validations: {class: User}, on: :create, on: :update
  validates_presence_of :name, :email
  validates_presence_of :password_confirmation, on: :create, on: :changepassProcess
  validates_length_of :password, :password_confirmation, minimum: 8, maximum: 40, on: :create, on: :changepassProcess

end