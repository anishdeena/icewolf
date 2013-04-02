class Friend < ActiveRecord::Base
  attr_accessible :credential_id, :name, :provider_type, :unique_id
  
  belongs_to :credential

  def self.addFBFriends(credential_id, fbfriends)
    Friend.transaction do
      fbfriends["data"].each do |fbfriend|
        friend = Friend.new
        friend.credential_id = credential_id
        friend.unique_id = fbfriend["id"]
        friend.name = fbfriend["name"]
        friend.provider_type = DatabaseConstants::SOCIALCONTACT_PROVIDERTYPE_FACEBOOK
        friend.save!
      end  
    end  
  end

end
