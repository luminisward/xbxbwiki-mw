DBname=`grep '$wgDBname' mediawiki/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
echo 'DBname:'$DBname
DBuser=`grep '$wgDBuser' mediawiki/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
echo 'DBuser:'$DBuser
DBpassword=`docker run --rm -it -v "$PWD":/var/www/html php:7-fpm php scripts/getDBPassword.php`
echo 'DBpassword:'$DBpassword

backupFile="xbxbwiki`date +%y%m%d_%H%M%S`.sql"

echo '$wgReadOnly = "'"Dumping Database, Access will be restored shortly"'";' >> mediawiki/LocalSettings.php
echo 'start dumping'
docker-compose exec mysql mysqldump -u$DBuser -p$DBpassword $DBname > $backupFile
echo 'dumping finished'
sed -i "/wgReadOnly/d" mediawiki/LocalSettings.php
sed -i "/mysqldump/d" $backupFile
gzip $backupFile
