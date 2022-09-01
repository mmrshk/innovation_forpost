class CreateReturnArticles < ActiveRecord::Migration[6.0]
  def change
    create_view :return_articles
  end
end
