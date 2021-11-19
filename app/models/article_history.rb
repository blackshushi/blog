class ArticleHistory < ApplicationRecord
  include TimeConverter
  belongs_to :article
  before_create :assign_version
  
  def edited_duration
    duration = Time.now - self.created_at

    humanize(duration)
  end

  private
  def assign_version
    self.version = self.article.article_histories.count + 1
  end
end
