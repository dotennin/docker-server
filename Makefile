SERVER_NAME         = $(subst _,.,$(subst -,.,$(notdir $(CURDIR))))
MYSQL_ROOT_PASSWORD = ${SERVER_NAME}
MYSQL_DATABASE      = ${SERVER_NAME}
MYSQL_USER          = ${SERVER_NAME}
MYSQL_PASSWORD      = ${SERVER_NAME}
NGINX_ROOT          = /var/www
.PHONY: test
test:
	@echo $(NGINX_ROOT)
	@echo $(SERVER_NAME)
	@echo ${MYSQL_USER}
	@echo ${MYSQL_PASSWORD}
	@echo ${MYSQL_DATABASE}
	@echo ${MYSQL_ROOT_PASSWORD}

.PHONY: install
install: 
	chmod +x .docker/install.sh
	.docker/install.sh $(SERVER_NAME) $(NGINX_ROOT)

up:
	cd $(PWD)/.docker/ && \
		export SERVER_NAME=$(SERVER_NAME) && \
		export NGINX_ROOT=$(NGINX_ROOT) && \
		docker-compose -p $(SERVER_NAME) up

.PHONY: remove
remove: 
	cd $(PWD)/.docker/ && \
	docker-compose -p $(SERVER_NAME) down --rmi all
	sudo sh -c "sed -i -e 's/127.0.0.1   $(SERVER_NAME)//g' /etc/hosts"
down:
	cd $(PWD)/.docker/ && \
	docker-compose -p $(SERVER_NAME) down

.PHONY: ssh $(t)
ssh:
	docker exec -it $(SERVER_NAME).$(filter-out $@,$(MAKECMDGOALS)) /bin/bash
%:
	@:
