class CreateArticlesDbViews < ActiveRecord::Migration[6.0]
  def change
    create_view :articles_db_views
  end
end
