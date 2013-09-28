class User
  include Mongoid::Document

  has_many :sources
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
                expire_time: auth_hash["credentials"]["expires_at"]
                )
            if @source.save
                @user
            else
                #error saving source
                @user.destroy
            end
        else
            #couldnt create user, error
        end
    end
end
end
