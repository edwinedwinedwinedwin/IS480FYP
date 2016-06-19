class User < ActiveRecord::Base
  #before_validation :compare
  validates_confirmation_of :password
  #validates_presence_of :password_confirmation, :if => :password_changed?
  #validates_presence_of :password_confirmation, :if => :password_changed?
  

  #def compare  	
  #	if password!=password_confirmation
  #		errors.add('passwords', 'do not match.')	
  #	else
  # end
  # end
  validates :username,:password,:email, :first_name, :last_name, :presence => true
  validates :email, :uniqueness => true



end
