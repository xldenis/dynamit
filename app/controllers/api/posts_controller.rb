class Api::PostsController < ApplicationController
  before_filter :authorized?
  before_filter :page_params
  def index
    @posts = current_user.posts.skip(@page_offset).limit(@page_size).desc(:created_time)
  end
end
