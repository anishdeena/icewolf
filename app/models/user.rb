class User < ActiveRecord::Base
  attr_accessible :age, :avatar_url, :credential_id, :firstname, :gender, :lastname
  
  belongs_to :credential
  
  def self.createUser(credential_id, member)
    user = User.new
    user.firstname = member["first_name"]
    user.lastname = member["last_name"]
    user.credential_id = credential_id
    user.avatar_url = 'http://graph.facebook.com/' + member["id"].to_s + '/picture'
    user.save!
  end
  
  def self.getAllProfileInformation(credential_id)
    user_info = self.getUserInfoDetails(credential_id)
    return user_info
  end
  
  def self.getUserInfoDetails(credential_id)
    user = nil
    user_info = self.includes(:credential).joins(:credential).where(:credential_id => credential_id, 
        :credentials => {:account_type => [DatabaseConstants::CREDENTIAL_ACTIVE_ACCOUNTTYPES]})
    if(user_info.length != 0)
       user = user_info[0]
    end
    return user
  end
  
  
end
