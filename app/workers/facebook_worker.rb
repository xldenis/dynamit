class FacebookWorker
  include Sidekiq::Worker

  def perform(source_id, offset=0)
   source = Source.find(source_id)


   graph = Koala::Facebook::API.new(source.token)
   posts = graph.get_connections("me","home",{:limit => 100, :offset => offset})
   posts.each do |post|
     type = (case post['type']
      when "photo"
        "picture"
      when "video"
        "video"
      else
        "link"
      end)
    p = source.posts.new(post_id:post['id'],
      descriptor:post['type'],
      message: {text: post['message']||post['story'],link: post[type]},
      created_time:post['created_time'],
      author:post['from'],
      link: post['link'],
      user: source.user)
    p.save
  end
end
end
