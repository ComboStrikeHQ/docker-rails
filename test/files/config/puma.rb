# frozen_string_literal: true
on_worker_boot do
  Redis.current.set('on_worker_boot', '1')
end
