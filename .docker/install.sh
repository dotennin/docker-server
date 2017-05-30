#!/bin/bash
cat /etc/hosts | grep $SERVER_NAME &> /dev/null;
if [ $? == 0 ]; then
	echo "Host writted";
else
	echo "Writting host name to /etc/hosts";
	sudo sh -c "echo '127.0.0.1   $SERVER_NAME' >> /etc/hosts";
fi

cd $PWD/.docker/ && \
docker-compose up  --build --force-recreate 
