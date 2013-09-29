class TimetrackerWorker
  include Sidekiq::Worker

  def perform(time_tracker)

    time_tracker.each do |trckr|

      post = Post.find_by(post_id:trckr['id'])
      if post
        post.inc({:tracker_time => trackr['time'] })
        post.update_score
        post.save
      end
    end
  end
end
