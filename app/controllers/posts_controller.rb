class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :ensure_admin!, except: [:index, :show, :publish, :unpublish]

  def index
    @posts = Post.search(params[:search])
                 .published
                 .order('created_at DESC')
                 .paginate(page: params[:page], per_page: 3)
    @categories = Category.all
    @recent_posts = Post.last(5)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @category = resolve_category_by_name(@post.category_id)
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
    @post = Post.find(params[:id])
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
    @post = Post.find(params[:id])
    @post.update_attributes(published: true)
    flash[:notice] = "Post #{@post.title} published"
    redirect_to admin_index_url
  end

  def unpublish
    @post = Post.find(params[:id])
    @post.update_attributes(published: false)
    flash[:notice] = "Post #{@post.title} unpublished"
    redirect_to admin_index_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :category_id, :published)
  end
end
