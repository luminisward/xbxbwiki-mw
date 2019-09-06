DBname=`grep '$wgDBname' xbxb/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
echo 'DBname:'$DBname
DBuser=`grep '$wgDBuser' xbxb/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
echo 'DBuser:'$DBuser
DBpassword=`docker run --rm -it -v "$PWD":/var/www/html php:7.1-fpm php scripts/getDBPassword.php`
echo 'DBpassword:'$DBpassword

MYSQL_CONTAINER=`docker ps | grep mysql | awk '{print $NF}'`

docker exec $MYSQL_CONTAINER mysql -u$DBuser -p$DBpassword -e "DROP DATABASE IF EXISTS $DBname;"
docker exec $MYSQL_CONTAINER mysql -u$DBuser -p$DBpassword -e "CREATE DATABASE $DBname;"
gunzip -c $1 | docker exec -i $MYSQL_CONTAINER mysql -u$DBuser -p$DBpassword $DBname
