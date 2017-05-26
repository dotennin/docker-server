SERVER_NAME         = $(subst _,.,$(subst -,.,$(notdir $(CURDIR))))
MYSQL_ROOT_PASSWORD = ${SERVER_NAME}
MYSQL_DATABASE      = ${SERVER_NAME}
MYSQL_USER          = ${SERVER_NAME}
MYSQL_PASSWORD      = ${SERVER_NAME}
text = /home/usr/
test:
	@echo ${SERVER_NAME}
	@echo ${MYSQL_USER}
	@echo ${MYSQL_PASSWORD}
	@echo ${MYSQL_DATABASE}
	@echo ${MYSQL_ROOT_PASSWORD}



.PHONY: install $(SERVER_NAME)
install: 
	export SERVER_NAME=$(SERVER_NAME)
	docker-compose up  --build

remove: 
	docker-compose down --rmi all
