class CategoriesController < ApplicationController
  def create
  end

  def destroy
  end

  def index
  	@categories = ActsAsTaggableOn::Tagging.where(context: "category").map{|tagging| tagging.tag}.uniq
  	#This returns all the tags that are used as categories
  	#Should categories just be a model? this is a little silly now because model logic will end up in the controller
  end
end
