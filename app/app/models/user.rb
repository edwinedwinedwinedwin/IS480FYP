class User < ActiveRecord::Base

  validates :email, :first_name, :last_name, :password, :presence => true
  validates :email, :uniqueness => true


end
