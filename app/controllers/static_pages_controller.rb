class StaticPagesController < ApplicationController
  
  before_action :require_login, only: [:admin]

  def about
  end

  def map
  	@locations = Location.all
  end

  def jet
  end

  def admin
  end
end
