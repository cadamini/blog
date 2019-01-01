class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  before_action :ensure_admin!, except: [:show]

  respond_to :html

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    @category.save!
    redirect_to admin_index_path
  end

  def update
    @category.update!(category_params)
    redirect_to admin_index_path
  end

  def destroy
    @category.destroy!
    redirect_to admin_index_path
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
