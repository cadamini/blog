class AddCommentsCountToPost < ActiveRecord::Migration[5.0]
 def self.up
    add_column :posts, :comments_count, :integer, :default => 0
    
    Post.reset_column_information
    Post.all.each do |p|
      Post.reset_counters p.id, :comments
    end
  end

  def self.down
    remove_column :posts, :comments_count
  end
end