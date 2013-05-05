class UserController < ApplicationController
skip_before_filter :authenticate, only: [:createUser]

  def createUser
    user = params[:user][:me]
    fbfriends = params[:user][:friends]
    json_data = ''
    status_symbol = :created
    begin
      json_data = Credential.createAndSyncUser(user, fbfriends)  
    rescue ActiveRecord::RecordInvalid => ex
      response.headers["custom_status_code"] = ErrorCodes::MEMBER_NOT_UNIQUE
      json_data = ex.message
      status_symbol = :unprocessable_entity
    end
    respond_to do |format|
      format.json { render json: json_data, status: status_symbol }
    end
  end

  def getUser
    userId = params[:id]
    current_user = getCurrentUserInfo()
    current_user_cred_id = getCredentialId(current_user)
    profileInformation = User.getAllProfileInformation(userId)
    respond_to do |format|
      if profileInformation
        format.json { render json: profileInformation , status: :ok}
      else
        format.json { render json: :no_content , status: :not_found } 
      end
    end
  end
  
  def getMe
    me = getCurrentUserInfo()
    respond_to do |format|
      if me
        format.json { render json: me, status: :accepted }
      else
        format.json { render json: me, status: :not_found }
      end
    end
  end
end
