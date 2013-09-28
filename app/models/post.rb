class Post
  include Mongoid::Document
  embedded_in :source
  field :create_time, :type => DateTime
  field :type
  field :message
  field :link
  field :post_id

  validates_presence_of :post_id
  validates_presence_of :type
  validates_presence_of :created_time
  validates_uniqueness_of :item_id
end
