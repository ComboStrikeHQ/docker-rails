workers ENV.fetch('PUMA_WORKERS', `nproc`).to_i

max_threads = ENV.fetch('PUMA_MAX_THREADS', 16).to_i
min_threads = ENV.fetch('PUMA_MIN_THREADS', max_threads).to_i
threads min_threads, max_threads

bind 'tcp://0.0.0.0:8080'
preload_app!

on_worker_boot do
  ActiveRecord::Base.establish_connection
end

custom_config = '/home/app/webapp/config/puma.rb'
instance_eval(File.read(custom_config)) if File.exist?(custom_config)
