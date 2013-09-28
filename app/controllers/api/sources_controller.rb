class Api::SourcesController < ApplicationController
  before_filter :authorized?
  def index
      @sources = current_user.sources
  end
  def show 
    @post = current_user.sources.find(params[:id])
  end
end
