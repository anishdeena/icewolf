class ApplicationController < ActionController::Base
  require 'db_constants.rb'
  require 'app_constants.rb'
  require 'error_codes.rb'
  require 'app_exception.rb'
  require 'opengraph'
  
  before_filter :authenticate
  protect_from_forgery

  def authenticate
    auth_failed = true
    begin
      auth_token = getAuthToken()
      
      if(auth_token)
        user_session = Session.getUserSessionDetails(auth_token)
        logger.debug user_session.inspect
        if(user_session)
          last_logged = user_session.last_accessed_at 
          logger.debug user_session.inspect
          last_logged = last_logged + AppConstants::TOKEN_EXPIRY_IN_HOURS.hours
          logger.debug last_logged
          if(last_logged > DateTime.now)
            Session.updateLastLoggedIn(user_session)
            auth_failed = false
          else
            Session.expireSessionBySession(user_session)
          end    
        end      
      end  
    
    rescue ActiveRecord::RecordNotFound => ex
      auth_failed = true 
      logger.error ex.message
      logger.error ex.backtrace
    end  
    if(auth_failed)
      respond_to do |format|
        format.json {render json: {error: 'authorization failed', }, status: :unauthorized}
      end
    end  
  end
  
  def getCurrentUserInfo
    auth_token = getAuthToken()
    user = Session.getCurrentUserInfo(auth_token)
    return user
  end
  
  def getAuthToken()
    return request.headers[AppConstants::AUTH_TOKEN_HEADER_NAME]
  end
  
  def getCredentialId(user)
    return user.credential_id
  end
  
  def handleStandardError(exception)
    message = "Some Problem in server"
    status_code = :internal_server_error
    logger.error exception.message
    logger.error exception.backtrace.join("\n")
    
    if(exception.kind_of?(ActiveRecord::RecordNotFound))
      message = "Record Not Found"
      #status_code = :internal
    elsif(exception.kind_of?(ActiveRecord::RecordInvalid))
      message = "Invalid Record"
      #status_code = :unprocessable_entity
    elsif(exception.kind_of?(ActiveRecord::RecordNotSaved))
      message = "Record not inserted/updated in DB"
      #status_code = :unprocessable_entity
    elsif(exception.kind_of?(ActiveRecord::StatementInvalid))
      message = "Problem with SQL statement"
      #status_code = :unprocessable_entity
    end
    
    respond_to do |format|
      format.json {render json: {error: message}, status: status_code}
    end
  end
    
end
