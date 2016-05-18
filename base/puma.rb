workers ENV.fetch('PUMA_WORKERS', `nproc`).to_i

max_threads = ENV.fetch('PUMA_MAX_THREADS', 16).to_i
min_threads = ENV.fetch('PUMA_MIN_THREADS', max_threads).to_i
threads min_threads, max_threads

bind 'tcp://0.0.0.0:8080'
preload_app!

# Don't wait for workers to finish their work. We might have long-running HTTP requests.
# But docker gives us only 10 seconds to gracefully handle our shutdown process.
# This settings tries to shut down all threads after 2 seconds. Puma then gives each thread
# an additional 5 seconds to finish the work. This adds up to 7 seconds which is still below
# docker's maximum of 10 seconds.
# This setting only works on Puma >= 3.4.0.
force_shutdown_after 2 if respond_to?(:force_shutdown_after)

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

custom_config = '/home/app/webapp/config/puma.rb'
instance_eval(File.read(custom_config)) if File.exist?(custom_config)
