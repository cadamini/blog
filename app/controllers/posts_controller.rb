class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :by_month]
  before_action :ensure_admin!, except: [:index, :by_month, :show, :publish, :unpublish]

  def index
    @posts = all_posts_or_by_params
              .order('created_at DESC')
              .paginate(page: params[:page], per_page: 20)
    @archive = published_posts_grouped_by_month
  end

  def edit
    @post = find_post_by_id
  end

  def new
    @post = Post.new
  end

  def show
    @post = find_post_by_id
    @category = category_name_for(@post.category_id)
    @archive = published_posts_grouped_by_month
  end

  def create
    post = Post.new(post_params)
    if post.save
      flash[:notice] = 'Post successfully created.' 
      redirect_to admin_index_path
    else
      flash[:error] = 'Post creation failed.'
      render :new
    end
  end

  def destroy
    post = find_post_by_id
    if post.destroy
      flash[:notice] = 'Post successfully deleted.'
      redirect_to admin_index_path
    else
      flash[:error] = 'Post deletion failed.'
      redirect_to admin_index_path
    end
  end

  def update
    post = find_post_by_id
    post.update_attributes(post_params)
    if post.save
      flash[:notice] = 'Post successfully updated.' 
    else
      flash[:error] = 'Post update failed.'
    end
    redirect_to post_path(params[:id])
  end

  def category_name_for(category_id)
    return 'none' if category_id.nil?
    Category.find(category_id).name
  end

  def publish
    post = find_post_by_id
    post.update_attributes(published: true)
    flash[:notice] = "Post #{@post.title} published"
    redirect_to admin_index_url
  end

  def unpublish
    post = find_post_by_id
    post.update_attributes(published: false)
    flash[:notice] = "Post #{@post.title} unpublished"
    redirect_to admin_index_url
  end

  def by_month
    @posts = Post.published.where('extract(month from created_at) = ?', params[:month])
    @archive = published_posts_grouped_by_month
  end

  private

  def all_posts_or_by_params
    posts = if params[:category_id]
              Category.find(params[:category_id]).posts
            elsif !params[:search].nil?
              Post.search(params[:search])
            else
              Post.all
            end
    posts.published
  end

  def published_posts_grouped_by_month
    Post.published.group_by { |t| t.created_at.month }
  end

  def find_post_by_id
    Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :category_id, :published, :image, :remote_image_url)
  end
end
