class Source
  include Mongoid::Document
  belongs_to :user
  has_many :posts

  field :provider
  field :token
  field :expire_time
  field :identifier
  field :secret
end
