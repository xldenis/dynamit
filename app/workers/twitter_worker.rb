class TwitterWorker
  include Sidekiq::Worker

   def perform(source_id)
     source = Source.find(source_id)

    posts = Twitter.home_timeline

    logger.error posts
    posts.each do |post|
      source.posts.create(post_id:post['id_str'],
                          descriptor:post['user']['name'],
                          message: {text:post['text'],link:post['profile_image_url']},
                          created_time:post['created_at'],
                          author:post['user']['screen_name']) # Might need to be changed to post.user[...]
    end
  end
end