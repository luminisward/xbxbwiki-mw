DBuser=`grep '$wgDBuser' mediawiki/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
DBpassword=`grep '$wgDBpassword' mediawiki/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
docker-compose exec mysql mysqldump -u$DBuser -p$DBpassword xbxbwiki > xbxbwiki`date +%y%m%d_%H%M%S`.sql
