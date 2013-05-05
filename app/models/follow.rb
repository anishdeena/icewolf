class Follow < ActiveRecord::Base
  attr_accessible :followee, :follower
end
