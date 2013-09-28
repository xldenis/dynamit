class SourcesController < ApplicationController	
  def index
  respond_to do |format|
  	format.html 
  	format.json {"index.json"}
  	end
  end
end
