class BookmarkController < ApplicationController
  
  def getMyBookmarks
    
  end
  
  def getBookmarks
    
  end
  
  def getBookmark
    
  end
  
  def saveBookmark
    article = params[:bookmark]
    current_user = getCurrentUserInfo()
    credential_id = getCredentialId(current_user)
    bookmark = Bookmark.saveBookmark(credential_id, article)
    respond_to do |format|
      if(bookmark)
        format.json {render json: bookmark, status: :created}
      else
        format.json {render json: :no_content, status: :unprocessable_entity}
      end    
    end
  end
  
end
