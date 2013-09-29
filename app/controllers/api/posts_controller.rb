class Api::PostsController < ApplicationController
  before_filter :authorized?
  before_filter :page_params
  def index
    @posts = current_user.posts.skip(@page_offset).limit(@page_size).desc(:created_time)
  end
  def track
  	params[:posts].each do |post|
  		ps = Post.find(post['id'])
  		if ps
  			ps.time += post['time']
  		end
  	end
  end
end
