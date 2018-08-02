MYSQL_CONTAINER=`docker ps | grep mysql | awk '{print $NF}'`

docker exec $MYSQL_CONTAINER mysql -uroot -pMjqVXTUhDgp4xsakiwT5 -e 'DROP DATABASE IF EXISTS xbxbwiki;' > /dev/null 2>&1
docker exec $MYSQL_CONTAINER mysql -uroot -pMjqVXTUhDgp4xsakiwT5 -e 'CREATE DATABASE xbxbwiki;' > /dev/null 2>&1
docker exec -i $MYSQL_CONTAINER mysql -uroot -pMjqVXTUhDgp4xsakiwT5 xbxbwiki < xbxbwiki.sql > /dev/null 2>&1
