class FacebookWorker
  include Sidekiq::Worker

   def perform(source_id)
     source = Source.find(source_id)

    graph = Koala::Facebook::API.new(source.token)
    posts = graph.get_connections("me","feed")
    logger.error posts
    posts.each do |post|
      source.posts.create(post_id:post['id'],
                          descriptor:post['type'],
                          message: {text: post['message']||post['story'],link:post['link']},
                          created_time:post['created_time'])
    end
  end
end
