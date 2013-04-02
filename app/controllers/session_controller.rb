class SessionController < ApplicationController
  
  def signIn
    fbuid = params[:session][:fbuid]
    json_output = nil
    status = :accepted
    begin
      json_output = Session.createSessionByFbUID(fbuid)
    rescue ActiveRecord::RecordNotFound => ex
      response.headers["custom_status_code"] = ErrorCodes::CREDENTIAL_NOT_FOUND
      logger.debug "RecordInvalid" 
      json_output = ex.message 
      status = :unprocessable_entity
    end
    respond_to do |format|
      format.json { render json: json_output, status: status}
    end
  end

  def signOut
    fp_auth_token = getAuthToken()
    user = UserSession.expireSession(fp_auth_token)
    respond_to do |format|
      if user
        format.json { render json: user, status: :created }
      else
        format.json { render json: user, status: :unprocessable_entity }
      end
    end
  end
end
