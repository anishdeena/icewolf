class BookmarkController < ApplicationController
  
  def getBookmarks
    options = params['options']
    logger.info 'OPTIONS ----------------------'
    logger.info params.inspect
    if !options
      options = Hash.new
    end
    offset = nil
    if options.has_key?('offset')
      offset = options['offset']
    end
    
    credential_id = nil
    if options.has_key?('credential_id')
      credential_id = options['credential_id']
    end
    
    search_term = nil
    if options.has_key?('search_term')
      search_term = options['search_term']
    end
        
    bookmarks = Bookmark.getBookmarks(search_term, credential_id, offset)
    respond_to do |format|
      if(bookmarks)
        format.json {render json: bookmarks, status: :created}
      else
        format.json {render json: :no_content, status: :unprocessable_entity}
      end    
    end      
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
