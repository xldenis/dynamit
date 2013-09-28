class Post
  include Mongoid::Document
  embedded_in :source
  field :create_time, :descriptor => DateTime

  # Holds the content type for a Facebook post, or the title of a RSS post
  field :descriptor

  # Holds the 'text' content of the post
  # (and the link of the attachement if there is one on facebook)
  field :message, type:Hash 
  field :link
  field :post_id
  field :author

  validates_presence_of :post_id
  validates_presence_of :descriptor
  validates_presence_of :created_time
  validates_uniqueness_of :item_id
end
