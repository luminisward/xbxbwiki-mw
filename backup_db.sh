DBname=`grep '$wgDBname' mediawiki/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
DBuser=`grep '$wgDBuser' mediawiki/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
DBpassword=`grep '$wgDBpassword' mediawiki/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`

backupFile="xbxbwiki`date +%y%m%d_%H%M%S`.sql"

docker-compose exec mysql mysqldump -u$DBuser -p$DBpassword $DBname > $backupFile
sed -i "/mysqldump/d" $backupFile
