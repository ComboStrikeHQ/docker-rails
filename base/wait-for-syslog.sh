#!/bin/bash

# syslog-ng takes a while to boot up. Once it's running, it prints a startup message
# to /var/syslog. Let's wait for that message to appear before we start logging anything.
while [ ! -s /var/log/syslog ]; do
  sleep 0.3
done
