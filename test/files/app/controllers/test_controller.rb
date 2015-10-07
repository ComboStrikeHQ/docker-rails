class TestController < ApplicationController
  def index
    Post.create!

    # The worker runs `Post.create!`. Wait for it to finish.
    TestWorker.perform_async
    sleep 2

    render text: message
  rescue StandardError => error
    render text: error
  end

  private

  def message
    return 'env_failed' unless ENV['TEST_ENV'] == 'hey'
    return 'post_count_failed' unless Post.count == 2
    'ok'
  end
end
