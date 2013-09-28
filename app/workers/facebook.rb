class FacebookWorker
  include Sidekiq::Worker

  def perform(source_id)
    source = source.find(source_id)

    graph = Koala::Facebook::API.new(source.token)
    posts = graph.get_connections("me","feed")
    posts.each do |post|
      source.posts.create(post_id:post['id'],
                          type:post['type'],
                          message['test']:post['message'],
                          message['link']:post['link'],
                          link:post['link'],
                          created_time:post['created_time'])
    end

  end
end
