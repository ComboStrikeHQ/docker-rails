# frozen_string_literal: true
# Directly exit - do not raise and report a SignalException
Signal.trap('TERM') { exit }

load 'config/clockwork.rb'

Clockwork.run
