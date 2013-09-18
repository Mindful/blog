class PicturesController < ApplicationController

  before_action :require_login, except: [:index]

  def new
  	@picture = Picture.new
  end

  def create
  end

  def index
  end
end
