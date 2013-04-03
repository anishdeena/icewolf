class Session < ActiveRecord::Base
  require 'digest/sha1'
  attr_accessible :auth_token, :credential_id, :expired, :last_accessed_at, :session_type
  belongs_to :credential
  
  def self.createSessionByFbUID(fbuid)
    usersession = nil
    credential = Credential.getCredentialDetailsByFBUID(fbuid)
    if !credential
      raise ActiveRecord::RecordNotFound.new("Credential Not Found!")
    end
    salt = BCrypt::Engine.generate_salt
    auth_token = Digest::SHA1.hexdigest(Digest::SHA1.hexdigest(salt))
    session_type = DatabaseConstants::USERSESSION_SESSIONTYPE_LOGIN
    usersession = self.create!(
      :credential_id => credential.id, 
      :auth_token => auth_token, 
      :session_type => session_type, 
      :last_accessed_at => Time.now, 
      :expired => false
    )
    return usersession
  end
  
  def self.getUserSessionDetails(auth_token)
    session = self.find_by_auth_token_and_expired(auth_token, false)
    if(session)
      Credential.getCredentialDetails(session.credential_id)
    end
    return session
  end
  
  def self.getCurrentUserInfo(auth_token)
    #user = []
    user_session = getUserSessionDetails(auth_token)
    user = User.getUserInfoDetails(user_session.credential_id)
    logger.debug user.credential.inspect
    #user.push({ usersession: user_session, member: member, credential: member.credential, circleuser: circle_user, circle: circle_user[0].circle , city: location })
    return user
  end
  
  
  def self.expireSessionBySession(user_session)
    user_session.expired = true
    user_session.save!
  end
  
  def self.expireSession(fp_auth_token)
    user_session = UserSession.find_by_auth_token(fp_auth_token)
    expireSessionBySession(user_session)
  end
  
  def self.updateLastLoggedIn(user_session)
    user_session.last_accessed_at = DateTime.now
    user_session.save!
  end


end
