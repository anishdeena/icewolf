class Credential < ActiveRecord::Base
  attr_accessible :account_type, :deleted, :email, :fbuid, :password, :salt
  
  has_one  :user
  has_many :accounts
  has_many :friends
  has_many :sessions
  
  def self.getCredentialDetailsByFBUID(fbuid)
    self.find_by_fbuid_and_account_type(fbuid, DatabaseConstants::CREDENTIAL_ACCOUNTTYPE_FACEBOOK)
  end
  
  def self.getCredentialDetails(credential_id)
    self.find_by_id_and_account_type(credential_id, DatabaseConstants::CREDENTIAL_ACCOUNTTYPE_FACEBOOK)
  end
  
  def self.createAndSyncUser(member, fbfriends)
    usersession = nil
    Credential.transaction do
      credential = Credential.new
      credential.email = member["email"]
      credential.account_type = DatabaseConstants::CREDENTIAL_ACCOUNTTYPE_FACEBOOK
      credential.fbuid = member["id"]
      credential.save!
      User.createUser(credential.id, member)
      Friend.addFBFriends(credential.id, fbfriends)
      Account.addAccountSync(credential.id, DatabaseConstants::EXTERNAUTH_PROVIDERTYPE_FACEBOOK, member["id"])
      usersession = Session.createSessionByFbUID(credential.fbuid)
    end
    return usersession
  end
  
  
end
