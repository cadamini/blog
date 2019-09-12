class AddTitleDescriptionToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :title, :string
    add_column :posts, :description, :text
    add_column :posts, :published, :boolean
  end
end
