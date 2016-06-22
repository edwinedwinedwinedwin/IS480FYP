class User < ActiveRecord::Base
  
  #validates_confirmation_of :password
  #validates_presence_of :password_confirmation, :if => :password_changed?
  #validates_presence_of :password_confirmation, :if => :password_changed?
  

  #def compare  	
  #	if password!=password_confirmation
  #		errors.add('passwords', 'do not match.')	
  #	else
  # end
  # end
  has_secure_password # use bcrypt methods to generate password digest = no password is stored in DB; only password digest stored.
  validates :password, :presence => true, :length => {:within => 8..40}, :confirmation => true
  #validates_confirmation_of :password
  #validates_confirmation_of :password, :message => "should match confirmation"
  validates :first_name, :last_name,:address, :presence => true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :email, :uniqueness => true
end
