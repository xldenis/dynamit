class User
  include Mongoid::Document

  has_many :sources
  has_many :posts
  def self.find_or_create_by_hash(auth_hash)
    @user = nil
    @source = Source.where(:provider => auth_hash["provider"], :identifier => auth_hash["uid"])
    if @source.first
        #assert only one source
        @user = @source.first.user
    else
        if @user = User.create
            @source = @user.sources.new(
                provider: auth_hash["provider"],
                identifier: auth_hash["username"],
                token: auth_hash["credentials"]["token"],
                secret: auth_hash["credentials"]["secret"],
                expire_time: auth_hash["credentials"]["expires_at"]
                )
            @source.user = @user
            if @source.save
                @user
            else
                @user.destroy
                #error saving source            end
            end
            #couldnt create user, error
        end
    end
    @user
end
end
