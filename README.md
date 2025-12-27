# docker-supercronic

Docker image for <https://github.com/aptible/supercronic/>.


```bash

cat >./crontab<<EOF
*/10 * * * * * * echo "hello from Supercronic"
*/30 * * * * * * bash -c "curl https://ipinfo.io"
EOF

docker run --name cron --rm -it -v ./crontab:/etc/crontab -e TZ=Asia/Shanghai dyrnq/supercronic:v0.2.41 -help

docker run --name cron --rm -it -v ./crontab:/etc/crontab -e TZ=Asia/Shanghai dyrnq/supercronic:v0.2.41 -inotify /etc/crontab

docker run --name cron --rm -it -v ./crontab:/etc/crontab -e TZ=Asia/Shanghai dyrnq/supercronic:v0.2.41 -passthrough-logs -inotify /etc/crontab
```

> Usage of supercronic

```bash
Usage of supercronic:
  -debug
        enable debug logging
  -inotify
        use inotify to detect crontab file changes
  -json
        enable JSON logging
  -no-reap
        disable reaping of dead processes, note: reaping requires pid 1
  -overlapping
        enable tasks overlapping
  -passthrough-logs
        passthrough logs from commands, do not wrap them in Supercronic logging
  -prometheus-listen-address string
        give a valid ip[:port] address to expose Prometheus metrics at /metrics (port defaults to 9746), use 0.0.0.0 for all network interfaces.
  -quiet
        do not log informational messages (takes precedence over debug)
  -sentry-dsn string
        enable Sentry error logging, using provided DSN
  -sentry-environment string
        specify the application's environment for Sentry error reporting
  -sentry-release string
        specify the application's release version for Sentry error reporting
  -sentryDsn string
        alias for sentry-dsn
  -split-logs
        split log output into stdout/stderr
  -test
        test crontab (does not run jobs)
  -version
        print version and exit
```
