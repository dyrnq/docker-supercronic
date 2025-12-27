# docker-supercronic

Docker image for <https://github.com/aptible/supercronic/>.


```bash

cat >./crontab<<EOF
*/10 * * * * * * echo "hello from Supercronic"
*/30 * * * * * * bash -c "curl https://ipinfo.io"
EOF

docker run --name cron -rm -it -v ./crontab:/etc/crontab -e TZ=Asia/Shanghai dyrnq/supercronic:v0.2.41 -help

docker run --name cron -rm -it -v ./crontab:/etc/crontab -e TZ=Asia/Shanghai dyrnq/supercronic:v0.2.41 /etc/crontab

docker run --name cron -rm -it -v ./crontab:/etc/crontab -e TZ=Asia/Shanghai dyrnq/supercronic:v0.2.41 -passthrough-logs /etc/crontab
```