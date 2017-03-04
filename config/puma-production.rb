bind 'tcp://[::]:3001'

directory '/opt/acao_dashboard/frontend/current'

threads 8,32
workers 3
preload_app!

state_path 'log/puma-production.state'
pidfile 'log/puma-production.pid'

plugin :systemd
