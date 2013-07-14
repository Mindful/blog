class CategoriesController < ApplicationController
  def create
  end

  def destroy
  end

  def index
  	@categories = Category.all
  end
end
