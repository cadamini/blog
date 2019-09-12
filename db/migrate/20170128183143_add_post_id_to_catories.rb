class AddPostIdToCatories < ActiveRecord::Migration[5.0]
  def change
  	add_column :categories, :post_id, :int
  end
end
