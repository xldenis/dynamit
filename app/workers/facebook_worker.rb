class FacebookWorker
  include Sidekiq::Worker

  # def perform(source_id)
  #   source = Source.find(source_id)

  #   graph = Koala::Facebook::API.new(source.token)
  #   posts = graph.get_connections("me","feed")
  #   posts.each do |post|
  #     source.posts.create(post_id:post['id'],
  #                         type:post['type'],
  #                         message: {text: post['message'],link:post['link']},
  #                         created_time:post['created_time'])
  #   end

  # end
  def perform(source_id)
    Source.find(source_id)
  end
end
