class SessionsController < ApplicationController
    def create
        @user = User.find_or_create_by_hash(request.env['omniauth.auth'])
        session[:current_user_id] = @user.id
        FacebookWorker.perform_async(@user.sources.first.id)
        redirect_to :root
    end
end
