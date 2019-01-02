class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :by_month]
  before_action :ensure_admin!, except: [:index, :by_month, :show, :publish, :unpublish]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :publish, :unpublish]

  def index
    posts = if params[:category_id]
              @category = Category.find(params[:category_id])
              @category.posts
            else
              Post.search(params[:search])
            end

    @posts = posts.published
                  .order('created_at DESC')
                  .paginate(page: params[:page], per_page: 3)

    @categories = Category.joins(:posts) #.uniq.sort
    @recent_posts = Post.published.last(5)
    @posts_by_month = Post.published.group_by { |m| m.created_at.beginning_of_month }
  end

  def edit
  end

  def new
    @post = Post.new
  end

  def show
    @category = resolve_category_by_name(@post.category_id)
    @categories = Category.joins(:posts).uniq.sort
    @recent_posts = Post.published.last(5)
    @posts_by_month = Post.published.group_by { |m| m.created_at.beginning_of_month }
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = 'Post successfully created'
      redirect_to admin_index_path
    else
      flash[:error] = 'Post creation failed'
      render :new
    end
  end

  def destroy
    if Post.find(params[:id]).destroy
      flash[:notice] = 'Post successfully deleted'
    else
      flash[:error] = 'Problem while deleting post'
    end
    redirect_to posts_path
  end

  def update
    @post.update_attributes(post_params)

    if @post.save
      flash[:notice] = "Post successfully updated"
      redirect_to post_path(params[:id])
    else
      flash[:error] = "Failed to update post with id #{params[:id]}"
      redirect_to posts_path
    end
  end

  def resolve_category_by_name(category_id)
    if category_id.nil?
      'none'
    else
      Category.find(category_id).name
    end
  end

  def publish
    @post.update_attributes(published: true)
    flash[:notice] = "Post #{@post.title} published"
    redirect_to admin_index_url
  end

  def unpublish
    @post.update_attributes(published: false)
    flash[:notice] = "Post #{@post.title} unpublished"
    redirect_to admin_index_url
  end

  def by_month
    @recent_posts = Post.published.last(5)
    @posts_by_month = Post.published.group_by { |m| m.created_at.beginning_of_month }
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :category_id, :published, :image, :remote_image_url)
  end
end
