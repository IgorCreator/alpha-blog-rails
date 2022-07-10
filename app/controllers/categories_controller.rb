class CategoriesController < ApplicationController

  def show
  end

  def index
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "New category [##{@category.name}] was created successfully."
      redirect_to @category
    else
      render 'new'
    end
  end

  def update
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
