class CategoriesController < ApplicationController
  def create
  	@category = Category.new(create_category_params)
  	if @category.save
  		redirect_to admin_index_path
  		flash[:success] = "Category Created"
  	else
  		setup_index
  	end
  end

  def destroy
  	if Category.find_by(name: params[:id]).destroy
  		redirect_to admin_index_path
  	else
  		flash.now[:error] = "Cannot delete category \"#{params[:id]}\" as it still contains posts"
  		@category = Category.new
  		setup_index
  	end
  end

  def index
  	@category = Category.new
  	setup_index
  end

  private
    def create_category_params
    	params.require(:category).permit(:name)
    end

    def setup_index
    	@categories = Category.all
    	render 'index'
    end
end
