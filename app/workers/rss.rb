class RSSWorker
  include Sidekiq::Worker

  def perform(source_id)
    source = source.find(source_id)

    posts = Feedzirra::Feed.fetch_and_parse(source.url)

    posts.entries.each do |post|
      source.posts.create(post_id:posts.etag,
                          type="RSS",
                          message['text']:post.content,
                          link:post.url,
                          created_time:post.published)




    # feed and entries accessors
    # feed.title          # => "Paul Dix Explains Nothing"
    # feed.url            # => "http://www.pauldix.net"
    # feed.feed_url       # => "http://feeds.feedburner.com/PaulDixExplainsNothing"
    # feed.etag           # => "GunxqnEP4NeYhrqq9TyVKTuDnh0"
    # feed.last_modified  # => Sat Jan 31 17:58:16 -0500 2009 # it's a Time object

    # entry = feed.entries.first
    # entry.title      # => "Ruby Http Client Library Performance"
    # entry.url        # => "http://www.pauldix.net/2009/01/ruby-http-client-library-performance.html"
    # entry.author     # => "Paul Dix"
    # entry.summary    # => "..."
    # entry.content    # => "..."
    # entry.published  # => Thu Jan 29 17:00:19 UTC 2009 # it's a Time object
    # entry.categories # => ["...", "..."]


    end

  end
end
