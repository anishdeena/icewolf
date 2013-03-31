class Credential < ActiveRecord::Base
  attr_accessible :account_type, :deleted, :email, :fbuid, :password, :salt
end
