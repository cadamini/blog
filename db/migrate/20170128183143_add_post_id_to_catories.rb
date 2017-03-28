class AddPostIdToCatories < ActiveRecord::Migration
  def change
  	add_column :categories, :post_id, :int
  end
end
