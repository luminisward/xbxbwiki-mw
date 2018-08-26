DBname=`grep '$wgDBname' mediawiki/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
DBuser=`grep '$wgDBuser' mediawiki/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`
DBpassword=`grep '$wgDBpassword' mediawiki/LocalSettings.php | awk -F "[\"\"]" '{print $2}'`

MYSQL_CONTAINER=`docker ps | grep mysql | awk '{print $NF}'`

docker exec $MYSQL_CONTAINER mysql -u$DBuser -p$DBpassword -e "DROP DATABASE IF EXISTS $DBname;"
docker exec $MYSQL_CONTAINER mysql -u$DBuser -p$DBpassword -e "CREATE DATABASE $DBname;"
docker exec -i $MYSQL_CONTAINER mysql -u$DBuser -p$DBpassword $DBname < $1
