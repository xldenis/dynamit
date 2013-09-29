class FacebookWorker
  include Sidekiq::Worker

  def perform(source_id, offset=0)
   source = Source.find(source_id)


   graph = Koala::Facebook::API.new(source.token)
   posts = graph.get_connections("me","home",{:limit => 100 :offset offset})
   posts.each do |post|
    p = source.posts.new(post_id:post['id'],
      descriptor:post['type'],
      message: {text: post['message']||post['story'],link:post['link']},
      created_time:post['created_time'],
      author:post['from'],
      user: source.user)
    p.save
  end
end
end
