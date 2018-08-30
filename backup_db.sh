DBname=`grep '$wgDBname' mediawiki/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
DBuser=`grep '$wgDBuser' mediawiki/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
DBpassword=`grep '$wgDBpassword' mediawiki/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`

backupFile="xbxbwiki`date +%y%m%d_%H%M%S`.sql"

echo '$wgReadOnly = "'"Dumping Database, Access will be restored shortly"'";' >> mediawiki/LocalSettings.php
docker-compose exec mysql mysqldump -u$DBuser -p$DBpassword $DBname > $backupFile
sed -i "/wgReadOnly/d" mediawiki/LocalSettings.php
sed -i "/mysqldump/d" $backupFile
gzip $backupFile
