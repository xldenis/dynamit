class Source
  include Mongoid::Document
  belongs_to :user
  has_many :posts

  field :provider
  field :token
  field :expire_time
  field :identifier
  field :secret

  validates_presence_of :token
  validates_presence_of :provider
 # validates_presence_of :expire_time
  validates_uniqueness_of :identifier, :scope => :provider
  def self.find_or_create(auth_hash)
    
    @source = Source.where(:provider => auth_hash["provider"],:identifier => (auth_hash["uid"]||auth_hash["username"])).first    
    unless @source != nil
      @source = Source.new(
        provider: auth_hash["provider"],
        identifier: (auth_hash["uid"]||auth_hash["username"]),
        token: auth_hash["credentials"]["token"],
        secret: auth_hash["credentials"]["secret"],
        expire_time: auth_hash["credentials"]["expires_at"]
        )
     @source.save
    end
      @source
    end
  end
