DBname=`grep '$wgDBname' xbxb/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
echo 'DBname:'$DBname
DBuser=`grep '$wgDBuser' xbxb/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
echo 'DBuser:'$DBuser
DBpassword=`php scripts/getDBPassword.php`
echo 'DBpassword:'$DBpassword

backupFile="xbxbwiki`date +%y%m%d_%H%M%S`.sql"

echo 'start dumping'
mysqldump -h127.0.0.1 -u$DBuser -p$DBpassword $DBname > $backupFile
echo 'dumping finished'
sed -i "/mysqldump/d" $backupFile
gzip $backupFile
