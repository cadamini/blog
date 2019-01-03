class AdminController < ApplicationController
  def index
    @posts = Post.all
    @categories = Category.all
  end

  def toggle_visibility
    post = Post.find(params[:id])
    if post.published == true
	  post.update_attributes(published: false)
	else
	  post.update_attributes(published: true)
	end
    flash[:notice] = "Post visibility has been changed for #{post.title}."
    redirect_to admin_index_url
  end
end
