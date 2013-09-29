class SessionsController < ApplicationController
	def create
		if session[:current_user_id]  == nil
			@user = User.find_or_create_by_hash(request.env['omniauth.auth'])
			session[:current_user_id] = @user.id
		else
			@user = current_user
			@source = Source.find_or_create(auth_hash)
			@source.user = @user
			@source.save
		end
		
		current_user.sources.each do |source|
			case source.provider
			when  "facebook"
				FacebookWorker.perform_async(source.id.to_s)
			when "twitter"
			    TwitterWorker.perform_async(source.id.to_s)
			end
		end
		redirect_to :root
	end
	def destroy
		if session[:current_user_id] != nil
			session[:current_user_id] == nil
		end
	end
	private
	def auth_hash
		request.env['omniauth.auth']
	end
end
