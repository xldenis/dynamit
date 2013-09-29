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
    @source = Source.where(:provider => auth_hash["provider"],:identifier => auth_hash["identifier"])
    logger.error "Source count: "<< @source.count.to_s
    
    unless @source.first != nil
      @source = Source.new(
        provider: auth_hash["provider"],
        identifier: auth_hash["identifier"],
        token: auth_hash["credentials"]["token"],
        secret: auth_hash["credentials"]["secret"],
        expire_time: auth_hash["credentials"]["expires_at"]
        )
     @source.save
    end
      @source
    end
  end
