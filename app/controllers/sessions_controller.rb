class SessionsController < ApplicationController
	def create
		if !current_user 
			@user = User.find_or_create_by_hash(request.env['omniauth.auth'])
			session[:current_user_id] = @user.id
		else
			@user = current_user
			@user.sources.create(
				provider: auth_hash["provider"],
				identifier: auth_hash["identifier"],
				token: auth_hash["credentials"]["token"],
				secret: auth_hash["credentials"]["secret"],
				expire_time: auth_hash["credentials"]["expires_at"]
				)
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
	private
	def auth_hash
		request.env['omniauth.auth']
	end
end
