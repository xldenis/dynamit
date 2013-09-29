class FacebookWorker
  include Sidekiq::Worker

   def perform(source_id)
     source = Source.find(source_id)

    graph = Koala::Facebook::API.new(source.token)
    posts = graph.get_connections("me","home",{:limit => 100})
    posts.each do |post|
      p = source.posts.new(post_id:post['id'],
                          descriptor:post['type'],
                          message: {text: post['message']||post['story'],link:post['link']},
                          created_time:post['created_time'],
                          user: source.user)
      p.save
    end
  end
end
