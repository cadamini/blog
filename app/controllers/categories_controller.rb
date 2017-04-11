class CategoriesController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_filter :ensure_admin!, except: [:show]

  def new
    @category = Category.new
   end

  def create
  	@category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      render :new
    end
  end

  def show
  	@category = Category.find(params[:id])
  	@posts = @category.posts.published
  end

  private

  def category_params
	  params.require(:category).permit(:name)
  end
end
