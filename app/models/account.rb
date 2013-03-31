class Account < ActiveRecord::Base
  attr_accessible :credential_id, :provider_type, :unique_id
end
