UID := $(shell id -u)
GID := $(shell id -g)

docker-build:
	docker build -t anvil:latest .

docker-run:
	docker run -it -v /dev:/dev -v .:/home/designer -w /home/designer anvil:latest bash
