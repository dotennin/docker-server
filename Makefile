SERVER_NAME         = $(subst _,.,$(subst -,.,$(notdir $(CURDIR))))
MYSQL_ROOT_PASSWORD = ${SERVER_NAME}
MYSQL_DATABASE      = ${SERVER_NAME}
MYSQL_USER          = ${SERVER_NAME}
MYSQL_PASSWORD      = ${SERVER_NAME}
container_name     = $(shell echo $@)

.PHONY: test
test:
	@echo ${container_name}
	@echo $(SERVER_NAME)
	@echo ${MYSQL_USER}
	@echo ${MYSQL_PASSWORD}
	@echo ${MYSQL_DATABASE}
	@echo ${MYSQL_ROOT_PASSWORD}

.PHONY: install
install: 
	chmod +x .docker/install.sh
	.docker/install.sh $(SERVER_NAME)

up:
	cd $(PWD)/.docker/ && \
		export SERVER_NAME=$(SERVER_NAME) && \
		docker-compose up

.PHONY: remove
remove: 
	cd $(PWD)/.docker/ && \
	docker-compose down --rmi all
	sudo sh -c "sed -i -e 's/127.0.0.1   $(SERVER_NAME)//g' /etc/hosts"

.PHONY: ssh $(t)
ssh:
	docker exec -it $(filter-out $@,$(MAKECMDGOALS)) /bin/bash
%:
	@:
