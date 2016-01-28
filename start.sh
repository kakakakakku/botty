# install mackerel-agent
cd /app/ && curl -O http://file.mackerel.io/agent/tgz/mackerel-agent-latest.tar.gz && tar xvfz mackerel-agent-latest.tar.gz
sh << SCRIPT
cat >/app/mackerel-agent/mackerel-agent.conf <<'EOF';
pidfile = "/app/mackerel-agent/mackerel-agent.pid"
root = "/app/mackerel-agent"
apikey = "${MACKEREL_API_KEY}"
roles = [ "${MACKEREL_SERVICE}:${MACKEREL_ROLE}" ]
[host_status]
on_start = "working"
EOF
SCRIPT
trap '/app/mackerel-agent/mackerel-agent retire -conf /app/mackerel-agent/mackerel-agent.conf -force' TERM
/app/mackerel-agent/mackerel-agent -conf /app/mackerel-agent/mackerel-agent.conf -v &

bin/hubot -a slack
