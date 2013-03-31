class Friend < ActiveRecord::Base
  attr_accessible :credential_id, :name, :provider_type, :unique_id
end
