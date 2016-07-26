# frozen_string_literal: true
class TestWorker
  include Sidekiq::Worker
  # put in non-default queue to test default sidekiq.yml
  sidekiq_options queue: :mailers

  def perform
    Post.create!
  end
end
