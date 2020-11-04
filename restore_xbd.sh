set -eu

DBname=`grep '$wgDBname' xbd/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
echo 'DBname:'$DBname
DBuser=`grep '$wgDBuser' xbd/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
echo 'DBuser:'$DBuser
DBpassword=`docker run --rm -v "$PWD":/var/www/html php:7.3-fpm php scripts/getDBPassword.php`
echo 'DBpassword:'$DBpassword

MYSQL_CONTAINER=`docker ps | grep mysql | awk '{print $NF}'`

echo "$(date) start"

docker exec $MYSQL_CONTAINER mysql -u$DBuser -p$DBpassword -e "DROP DATABASE IF EXISTS $DBname;" &&
docker exec $MYSQL_CONTAINER mysql -u$DBuser -p$DBpassword -e "CREATE DATABASE $DBname;" &&
gunzip -c $1 | docker exec -i $MYSQL_CONTAINER mysql -u$DBuser -p$DBpassword $DBname

echo "$(date) finished"
