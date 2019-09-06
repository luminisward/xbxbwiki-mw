DBname=`grep '$wgDBname' xbxb/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
echo 'DBname:'$DBname
DBuser=`grep '$wgDBuser' xbxb/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
echo 'DBuser:'$DBuser
DBpassword=`php scripts/getDBPassword.php`
echo 'DBpassword:'$DBpassword

backupFile="xbxbwiki`date +%y%m%d_%H%M%S`.sql"

echo '$wgReadOnly = "'"Dumping Database, Access will be restored shortly"'";' >> xbxb/LocalSettings.php
echo 'start dumping'
mysqldump -h127.0.0.1 -u$DBuser -p$DBpassword $DBname > $backupFile
echo 'dumping finished'
sed -i "/wgReadOnly/d" xbxb/LocalSettings.php
sed -i "/mysqldump/d" $backupFile
gzip $backupFile
