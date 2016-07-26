# frozen_string_literal: true
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
    return 'custom_puma_config_failed' unless Redis.current.get('on_worker_boot') == '1'
    return 'clockwork_failed' unless Redis.current.get('clockwork_test') == '1'
    'ok'
  end
end
