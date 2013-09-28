class SessionsController < ApplicationController
  def create
    if !current_user 
      @user = User.find_or_create_by_hash(request.env['omniauth.auth'])
      session[:current_user_id] = @user.id
      FacebookWorker.perform_async(@user.sources.first.id.to_s)
      redirect_to :root
    else
      @user = current_user
      @user.sources.create(
        provider: auth_hash["provider"],
        identifier: auth_hash["identifier"],
        token: auth_hash["credentials"]["token"],
        secret: auth_hash["credentials"]["secret"]
        expire_time: auth_hash["credentials"]["expires_at"]
        )
    end
  end
