bind 'tcp://[::]:3331'

threads 2,8
workers 2
preload_app!

state_path 'log/puma.state'
pidfile 'log/puma.pid'
