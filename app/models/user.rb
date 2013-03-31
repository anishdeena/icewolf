class User < ActiveRecord::Base
  attr_accessible :age, :avatar_url, :credential_id, :firstname, :gender, :lastname
end
