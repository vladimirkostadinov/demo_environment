/usr/sbin/haproxy -f /home/${NODE_NAME}admin/jenkins/workspace/Clone-GitHub-project/haproxy_config/haproxy.cfg -c && /usr/sbin/haproxy -f /home/${NODE_NAME}admin/jenkins/workspace/Clone-GitHub-project/haproxy_config/haproxy.cfg -p /var/run/haproxy.pid -sf $(cat /var/run/haproxy.pid)
