class UserController < ApplicationController

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
    profileInformation = MemberInfo.getAllProfileInformation(userId)
    if(profileInformation)
      if current_user_cred_id != userId
        UserStat.addStatsForView(current_user_cred_id, userId)
      end
    end
    respond_to do |format|
      if profileInformation
        format.json { render json: profileInformation , status: :ok}
      else
        format.json { render json: :no_content , status: :not_found } 
      end
    end
  end
end
