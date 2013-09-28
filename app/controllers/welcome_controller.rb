class WelcomeController < ApplicationController
  def index
  respond_to do |format|
  	format.html {"index.json"}
  	format.json {"index.json"}
  	end
  end
end
