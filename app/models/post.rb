class Post

  include Mongoid::Document
  belongs_to :source
  belongs_to :user
  
  field :created_time, type:DateTime

  # Holds the content type for a Facebook post, or the title of a RSS post
  field :descriptor

  # Holds the 'text' content of the post
  # (and the link of the attachement if there is one on facebook)
  field :message, type:Hash

  # Holds the link to acces directly to the post
  field :link

  # Holds the Facebook post_id or the etag of the RSS feed
  field :post_id

  field :author

  field :tracker_time

  field :time, type:Integer
  validates_presence_of :post_id
  validates_presence_of :descriptor
  validates_presence_of :created_time
  validates_uniqueness_of :post_id

  def self.update_tracker(posts)
    posts.each do |p|
      post = Post.find_by(post_id:p['id'])
      if post
        time = (p['time'] > 10000)? 1000 : p['time']/10
        post.inc({:tracker_time => time})
        post.save
      end
    end
  end

  def compute_score()
    score = tracker_time / message["text"].length
    tracker_time /= 2
    save
    score
  end

  def compute_author_score(posts)
    last_ten = posts.find(author:author, :limit => 11, :order=> 'created_at desc')
    if last_ten.length > 10
      last_ten.each do |p|
        sum += p.compute_score
      end
    end
  end


end
