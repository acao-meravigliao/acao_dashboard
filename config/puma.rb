bind 'tcp://[::]:3331'

threads 8,32
workers 3
preload_app!

state_path 'log/puma.state'
pidfile 'log/puma.pid'
