bind 'tcp://[::]:3001'

directory '/opt/acao-dashboard/current'

threads 8,32
workers 3
preload_app!

state_path 'log/puma-staging.state'
pidfile 'log/puma-staging.pid'

plugin :systemd
