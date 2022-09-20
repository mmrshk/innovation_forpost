class AddLanguageToAnswers < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :language, :integer, default: 0
  end
end
