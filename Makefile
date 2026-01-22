.PHONY: up down build test logs

up:
	docker-compose up -d --build

down:
	docker-compose down

build:
	docker-compose build

logs:
	docker-compose logs -f

test:
	# Example: run pytest in all services
	docker-compose run --rm auth pytest
	docker-compose run --rm catalog pytest
	docker-compose run --rm cart pytest
	docker-compose run --rm order pytest
	docker-compose run --rm payment pytest
	docker-compose run --rm inventory pytest

