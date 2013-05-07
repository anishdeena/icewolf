class BookmarkController < ApplicationController
  
  def getBookmarks
    
  end
  
  def getBookmarksByUser
    credential_id = params[:id]
    bookmarks = Bookmark.getBookmarksByUser(credential_id)
    respond_to do |format|
      if(bookmarks)
        format.json {render json: bookmarks, status: :created}
      else
        format.json {render json: :no_content, status: :unprocessable_entity}
      end    
    end    
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
