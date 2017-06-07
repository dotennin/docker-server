#!/bin/bash
cat /etc/hosts | grep $1 &> /dev/null;
if [ $? == 0 ]; then
	echo "Host writted";
else
	echo "Writting host name to /etc/hosts";
	sudo sh -c "echo '127.0.0.1   $1' >> /etc/hosts";
fi

cd $PWD/.docker/ && \
	export SERVER_NAME=$1 && \
	export NGINX_ROOT=$2 && \
	docker-compose up  --build --force-recreate 
