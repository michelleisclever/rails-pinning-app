class User < ActiveRecord::Base
    
    
  validates_presence_of :email, :password
  validates_uniqueness_of :email
    
    
    def self.authenticate(email, password)
        user = User.find_by_email(:email)
        if user && user.authenticate(password)
            return user
        else
            nil
  end
end
end