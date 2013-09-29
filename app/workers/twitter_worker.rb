class TwitterWorker
  include Sidekiq::Worker

  def perform(source_id)
   source = Source.find(source_id)
   client = Twitter::Client.new 
    client.oauth_token         = source.token
    client.oauth_token_secret  = source.secret
  
  puts client
  posts = client.home_timeline(:count => 150)

  logger.error posts
  posts.each do |post|
    ps = source.posts.new(post_id:post.id,
      descriptor:post.user.name,
      message: {text:post.text,link:post.profile_image_url},
      created_time:post.created_at,
                          author:post.user.screen_name) # Might need to be changed to post.user[...]
    ps.user = source.user
    ps.save
  end
end
end