class Api::PostsController < ApplicationController
  before_filter :authorized?
  before_filter :page_params
  def index
    @posts = current_user.posts.skip(@page_offset).limit(@page_size).desc(:created_time)
  end
  def track
    if params[:_json]
      Post.update_tracker(params[:_json])
      render nothing: true, status: 200
    end
    render nothing: true, status: 400
  end
end
