class Account < ActiveRecord::Base
  attr_accessible :credential_id, :provider_type, :unique_id
  
  belongs_to :credential

  def self.addAccountSync(credential_id, provider_type, unique)
    self.create!(:credential_id => credential_id, :provider_type => provider_type, :unique_id => unique)
  end  

end
