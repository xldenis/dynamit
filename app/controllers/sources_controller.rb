class SourcesController < ApplicationController	
  before_filter :authorized?
  def index
  respond_to do |format|
  	format.html 
  	format.json {"index.json"}
  	end
  end
end
