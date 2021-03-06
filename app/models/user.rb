class User < ActiveRecord::Base   
    
    has_secure_password
    has_many :pins
    
  validates_presence_of :first_name, :last_name, :email, :password
  validates_uniqueness_of :email

    #def has_password?(password)
        #password = #User.find_by_password(password)
   # end
    
    def self.authenticate(email, password)
      @user = User.find_by_email(email)
 
  if !@user.nil?
    if @user.authenticate(password)
      return @user
    end
  end
 
  return nil
end

end