# This configuration file will be evaluated by Puma. The top-level methods that
# are invoked here are part of Puma's configuration DSL. For more information
# about methods provided by the DSL, see https://puma.io/puma/Puma/DSL.html.
#
# Puma starts a configurable number of processes (workers) and each process
# serves each request in a thread from an internal thread pool.
#
# You can control the number of workers using ENV["WEB_CONCURRENCY"]. You
# should only set this value when you want to run 2 or more workers. The
# default is already 1.
#
# The ideal number of threads per worker depends both on how much time the
# application spends waiting for IO operations and on how much you wish to
# prioritize throughput over latency.
#
# As a rule of thumb, increasing the number of threads will increase how much
# traffic a given process can handle (throughput), but due to CRuby's
# Global VM Lock (GVL) it has diminishing returns and will degrade the
# response time (latency) of the application.
#
# The default is set to 3 threads as it's deemed a decent compromise between
# throughput and latency for the average Rails application.
#
# Any libraries that use a connection pool or another resource pool should
# be configured to provide at least as many connections as the number of
# threads. This includes Active Record's `pool` parameter in `database.yml`.
max_threads_count = ENV.fetch("RAILS_MAX_THREADS", 5).to_i
min_threads_count = ENV.fetch("RAILS_MIN_THREADS", max_threads_count).to_i
threads min_threads_count, max_threads_count

# ワーカー数（プロセス数）。単一サーバなら 0〜2 程度から。
workers ENV.fetch("WEB_CONCURRENCY", 0).to_i

# ワーカーを使うならフォーク前読み込みで省メモリ＆高速化
preload_app! if Integer(ENV.fetch("WEB_CONCURRENCY", 0)) > 0

# フォーク前後のDB接続の扱い（PostgreSQL）
before_fork do
  ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
end
on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

## Render で確実に検出されるよう 0.0.0.0:$PORT に明示バインド
bind "tcp://0.0.0.0:#{ENV.fetch('PORT', 3000)}"

## 念のため環境も明示
environment ENV.fetch("RAILS_ENV", "production")

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart


# plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"] == "1"

# Specify the PID file. Defaults to tmp/pids/server.pid in development.
# In other environments, only set the PID file if requested.
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]
