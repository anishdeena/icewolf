class FriendController < ApplicationController
  
  def getAllFBFriends
    friends = Friend.all
    respond_to do |format|
      format.json { render json: friends, status: :accepted }
    end     
  end
  
end
