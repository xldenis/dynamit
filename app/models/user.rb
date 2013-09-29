class User
  include Mongoid::Document

  has_many :sources
  has_many :posts
  def self.find_or_create_by_hash(auth_hash)
    @source = Source.where(:provider => auth_hash["provider"], :identifier => auth_hash["identifier"])
    if @source.first
        #assert only one source
        @user = @source.first.user
    else
        if @user = User.create
            @source = @user.sources.new(
                provider: auth_hash["provider"],
                identifier: auth_hash["identifier"],
                token: auth_hash["credentials"]["token"],
                secret: auth_hash["credentials"]["secret"],
                expire_time: auth_hash["credentials"]["expires_at"]
                )
            @source.user = @user
            if @source.save
                @user
            else
                #error saving source            end
            end
            #couldnt create user, error
        end
    end
end
end
