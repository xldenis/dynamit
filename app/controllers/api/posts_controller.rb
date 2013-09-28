class Api::PostsController < ApplicationController
  before_filter :authorized?
def index
  # @feed = current_user.sources.find(params[:source_id])
  # @post = @feed.posts.limit(25)
  @posts = current_user.posts.limit(25)
end
end
