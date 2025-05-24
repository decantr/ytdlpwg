all: clean build bg

build:
	docker compose build

logs:
	docker compose logs

run:
	docker compose run yt-dlp

bg:
	docker compose up -d

attach:
	docker compose exec -it yt-dlp bash

down:
	docker compose down

clean:
	docker compose down --remove-orphans

# askubuntu.com a 1448109
Arguments := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))

dl:
	docker compose exec -it yt-dlp yt-dlp "$(Arguments)"
