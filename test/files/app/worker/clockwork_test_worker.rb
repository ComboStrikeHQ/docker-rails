# frozen_string_literal: true
class ClockworkTestWorker
  include Sidekiq::Worker

  def perform
    Redis.current.set('clockwork_test', '1')
  end
end
