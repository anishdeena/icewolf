class Session < ActiveRecord::Base
  attr_accessible :auth_token, :credential_id, :expired, :last_accessed_at, :session_type
end
