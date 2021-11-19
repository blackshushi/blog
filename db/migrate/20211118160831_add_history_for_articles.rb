class AddHistoryForArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :article_histories do |t|
      t.timestamps
      t.string :title
      t.string :body
      t.references :article
    end
  end
end
