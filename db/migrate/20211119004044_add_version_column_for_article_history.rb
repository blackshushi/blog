class AddVersionColumnForArticleHistory < ActiveRecord::Migration[6.1]
  def change
    add_column :article_histories, :version, :integer
  end
end
