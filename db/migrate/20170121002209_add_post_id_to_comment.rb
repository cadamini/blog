class AddPostIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :post_id, :int
  end
end
