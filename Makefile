FOLDER=-f srcs/docker-compose.yml

build:
	@docker-compose $(FOLDER) build

run:
	@mkdir -p ~/data/web ~/data/mariadb
	@docker-compose $(FOLDER) up  --build

stop:
	@docker-compose $(FOLDER) down

clean:
	@docker-compose $(FOLDER) down -v

fclean: clean
	@docker ps -qa | xargs -r docker stop
	@docker ps -qa | xargs -r docker rm
	@docker images -qa | xargs -r docker rmi -f
	@docker volume ls -q | xargs -r docker volume rm
	@docker network ls -q | grep -v 'bridge\|host\|none' | xargs -r docker network rm
	@sudo rm -rf ~/data/

re:
	@make fclean && make run


.PHONY: build run stop clean