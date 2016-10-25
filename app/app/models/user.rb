class User < ActiveRecord::Base
  has_many :projects
  has_many :project_members
  has_many :user_expertises

  mount_uploader :profile_pic, ProfilePicUploader
  validates :profile_pic, file_size: { less_than: 2.megabytes }
  
  has_secure_password # use bcrypt methods to generate password digest = no password is stored in DB; only password digest stored.
  validates :password, :length => {:within => 8..40},:on => :create # presence is automatically validated here
  validates :password_confirmation, :presence => { :message => "cannot be blank" },:on => :create
  # password validation > alphanumeric and NO BLANKS
  validates :name, :presence => true
  validates :fb_url, :presence => true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :email, :uniqueness => true # ensure email has not been registered before

end