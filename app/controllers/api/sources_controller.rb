class Api::SourcesController < ApplicationController
  before_filter :authorized?
  def index
      @sources = current_user.sources
  end
  def show 
    @source = current_user.sources.find(params[:id])
    @posts = @source.posts.limit(25)
  end
end
