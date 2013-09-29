class TimetrackerWorker
  include Sidekiq::Worker

  def perform(time_tracker)

    time_tracker.each do |trckr|

      post = Post.find(post_id:trckr['id'])
      if post
        post.time += trackr['time']
        post.save
      end
    end
  end
end
