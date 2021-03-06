set -eu

# xbxb
DBname=`grep '$wgDBname' xbxb/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
echo 'DBname:'$DBname
DBuser=`grep '$wgDBuser' xbxb/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
echo 'DBuser:'$DBuser
DBpassword=`docker run --rm -v "$PWD":/var/www/html php:7.3-fpm php scripts/getDBPassword.php`
echo 'DBpassword:'$DBpassword

MYSQL_CONTAINER=`docker ps | grep mysql | awk '{print $NF}'`
backupFile="xbxbwiki`date +%y%m%d_%H%M%S`.sql"

echo "$(date) start"

docker exec $MYSQL_CONTAINER sh -c "exec mysqldump -u$DBuser -p$DBpassword $DBname" > $backupFile
echo "$(date) finished: $backupFile"

gzip $backupFile
echo "$(date) gzip finished"


# xbd
DBname=`grep '$wgDBname' xbd/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
echo 'DBname:'$DBname
DBuser=`grep '$wgDBuser' xbd/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
echo 'DBuser:'$DBuser
DBpassword=`docker run --rm -v "$PWD":/var/www/html php:7.3-fpm php scripts/getDBPassword.php`
echo 'DBpassword:'$DBpassword

MYSQL_CONTAINER=`docker ps | grep mysql | awk '{print $NF}'`
backupFile="xbdwiki`date +%y%m%d_%H%M%S`.sql"

echo "$(date) start"

docker exec $MYSQL_CONTAINER sh -c "exec mysqldump -u$DBuser -p$DBpassword $DBname" > $backupFile
echo "$(date) finished: $backupFile"

gzip $backupFile
echo "$(date) gzip finished"
