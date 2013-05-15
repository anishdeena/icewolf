class Bookmark < ActiveRecord::Base
  include PgSearch
  attr_accessible :id, :article_id, :comment, :credential_id, :tags
  
  belongs_to :article
  belongs_to :credential

  pg_search_scope :search, against: [:tags, :comment],
    :associated_against => {
      :article => [:title, :tags, :url, :description]
    },
    using: {tsearch: {:dictionary => "english", :any_word => true}}
      
  def self.saveBookmark(credential_id, article)
    Bookmark.transaction do
      new_article = Article.find_by_url(article["url"])
      if new_article
        article_stats = ArticleStats.find_by_article_id(new_article.id)
        article_stats.count_bookmark = article_stats.count_bookmark + 1
        article_stats.count_view = article_stats.count_view + 1
        article_stats.save!
        bookmark = Bookmark.new
        bookmark.article_id = new_article.id
        bookmark.credential_id = credential_id
        if article["comment"]
          bookmark.comment = article["comment"]
        end
        if article["tags"]
          bookmark.tags = article["tags"]
        end
        bookmark.save!
        return bookmark         
      else
        og = OpenGraph.fetch(article["url"])
        doc = Nokogiri::HTML(open(article["url"]))
        keyword_tags = doc.at_css('meta[name="keywords"]').attributes["content"].value
        new_article = Article.new
        if og
          if og.url
            new_article.url = og.url
          else
            new_article.url = article["url"]
          end
          if og.title
            new_article.title = og.title
          else
            new_article.title = article["url"]
          end
          new_article.description = og.description
          new_article.image_url = og.image
        else
          new_article.title = article["url"]
          new_article.url = article["url"]
        end
        if keyword_tags
          new_article.tags = keyword_tags
        end 
        new_article.save!
        article_stats = ArticleStats.new
        article_stats.article_id = new_article.id
        article_stats.count_bookmark = 1
        article_stats.count_view = 1
        article_stats.save!
        bookmark = Bookmark.new
        bookmark.article_id = new_article.id
        bookmark.credential_id = credential_id
        if article["comment"]
          bookmark.comment = article["comment"]
        end
        if article["tags"]
          bookmark.tags = article["tags"]
        end
        bookmark.save!
        return bookmark         
      end
    end
  end
  
  def self.getBookmarksByUser(credential_id)
    bookmark_collection = []
    bookmarks = self.includes(:credential).includes(:article).joins(:credential).joins(:article).where(:credential_id => credential_id)
    bookmarks.each do |bookmark|
      user = User.find_by_credential_id(bookmark.credential.id)
      article_stats = ArticleStats.find_by_article_id(bookmark.article.id)
      bookmark_collection.push({ bookmark: bookmark, article: bookmark.article, article_stats: article_stats, user: user })
    end
    logger.info bookmarks.inspect
    return bookmark_collection
  end
  
  def self.getBookmarks(search_term, credential_id, offset)
    limit = 10
    data = []
    bookmark_collection = []
    rel = scoped
    rel = rel.joins(:credential)
    rel = rel.joins(:article)
    #rel = rel.order("bookmarks.id")
    if credential_id
      rel = rel.where(:credential_id => credential_id) 
    end
    if search_term
      rel = rel.search(search_term)
    end
    rel = rel.limit(limit)
    rel = rel.offset(offset)
    
    offset = offset.to_i + rel.count
    rel.each do |bookmark|
      user = User.find_by_credential_id(bookmark.credential_id)
      article = Article.find(bookmark.article_id)
      article_stats = ArticleStats.find_by_article_id(article.id)
      bookmark_collection.push({ bookmark: bookmark, article: article, article_stats: article_stats, user: user })
    end
    data.push({ bookmark_collection: bookmark_collection, offset: offset })
    return data
  end
end
