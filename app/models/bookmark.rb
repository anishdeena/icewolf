class Bookmark < ActiveRecord::Base
  attr_accessible :article_id, :comment, :credential_id, :tags
  
  belongs_to :article
  belongs_to :credential
  
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
          new_article.url = og.url
          new_article.title = og.title
          new_article.description = og.description
          new_article.image_url = og.image
        else
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
    bookmarks = self.includes(:credential).includes(:article).joins(:credential).joins(:article).where(:credential_id => credential_id)
    logger.info bookmarks.inspect
    return bookmarks
  end
end
