# docker-supercronic

Docker image for <https://github.com/aptible/supercronic/>.


```bash

cat >./crontab<<EOF
*/10 * * * * * * echo "hello from Supercronic"
EOF

docker run --name cron -rm -it -v ./crontab:/etc/crontab -e TZ=Asia/Shanghai dyrnq/supercronic:v0.2.41 -help

docker run --name cron -rm -it -v ./crontab:/etc/crontab -e TZ=Asia/Shanghai dyrnq/supercronic:v0.2.41 /etc/crontab

docker run --name cron -rm -it -v ./crontab:/etc/crontab -e TZ=Asia/Shanghai dyrnq/supercronic:v0.2.41 -debug /etc/crontab
```