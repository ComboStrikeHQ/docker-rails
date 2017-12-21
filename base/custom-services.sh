#!/bin/bash -e

for fname in /home/app/webapp/bin/services/*; do
  [ -f "$fname" ] || continue
  service=$(basename "${fname%.*}")
  mkdir "/etc/service/$service"

  cat <<STR > "/etc/service/$service/run"
#!/bin/bash

cd /home/app/webapp

/opt/wait-for-syslog.sh
exec chpst -u app bundle exec "$fname" \
  2>&1 |logger -t "$service"
STR
  chmod +x "/etc/service/$service/run"
done
