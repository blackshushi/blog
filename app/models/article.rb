class Article < ApplicationRecord
  include Visible
  has_many :comments, dependent: :destroy
  has_many :article_histories
  after_save :save_article_history

  validates_presence_of :title, :body, :author
  validates :body, length: {minimum: 10}

  private
  def save_article_history
    self.article_histories.create(title: self.title, body: self.body)
  end
end

