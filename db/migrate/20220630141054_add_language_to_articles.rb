class AddLanguageToArticles < ActiveRecord::Migration[6.0]
  def change
    # create_enum "languages", %w[ukr eng]
    # add_column :articles, :language, :languages
    add_column :articles, :language, :integer, default: 0
  end
end
