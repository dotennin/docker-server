SERVER_NAME         = $(subst _,.,$(subst -,.,$(notdir $(CURDIR))))
MYSQL_ROOT_PASSWORD = ${SERVER_NAME}
MYSQL_DATABASE      = ${SERVER_NAME}
MYSQL_USER          = ${SERVER_NAME}
MYSQL_PASSWORD      = ${SERVER_NAME}
WORKING_DIR         = /var/www
NGINX_ROOT          = ${WORKING_DIR}

define init
$(1): export SERVER_NAME=$(SERVER_NAME)
$(1): export NGINX_ROOT=$(NGINX_ROOT)
$(1): export WORKING_DIR=$(WORKING_DIR)
$(1): export MYSQL_ROOT_PASSWORD=$(MYSQL_ROOT_PASSWORD)
$(1): export MYSQL_DATABASE=$(MYSQL_DATABASE)
$(1): export MYSQL_USER=$(MYSQL_USER)
$(1): export MYSQL_PASSWORD=$(MYSQL_PASSWORD)
endef
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
	.docker/install.sh $(SERVER_NAME) $(NGINX_ROOT) $(WORKING_DIR) $(MYSQL_ROOT_PASSWORD) $(MYSQL_DATABASE) $(MYSQL_USER) $(MYSQL_PASSWORD)

$(eval $(call init,up))
up: 
	cd $(PWD)/.docker/ && \
		docker-compose -p $(SERVER_NAME) up -d

.PHONY: remove

$(eval $(call init,remove))
remove:
	cd $(PWD)/.docker/ && \
	docker-compose -p $(SERVER_NAME) down --rmi all --volumes
	sudo sh -c "sed -i -e 's/127.0.0.1   $(SERVER_NAME)//g' /etc/hosts"

$(eval $(call init,down))
down: 
	cd $(PWD)/.docker/ && \
		docker-compose -p $(SERVER_NAME) down
monitor:
	docker stats $(docker inspect -f {{.NAME}} $(docker ps -q))
cleanup: 
	docker system prune --all --volumes

.PHONY: ssh $(t)
ssh:
	docker exec -it $(SERVER_NAME).$(filter-out $@,$(MAKECMDGOALS)) /bin/bash
%:
	@:
