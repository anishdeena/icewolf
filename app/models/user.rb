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
end
