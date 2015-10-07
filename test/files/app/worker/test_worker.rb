class TestWorker
  include Sidekiq::Worker

  def perform
    Post.create!
  end
end
