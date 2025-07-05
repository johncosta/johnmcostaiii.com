server:
	hugo server

build:
	hugo --gc --minify --config hugo.toml

clean:
	rm -rf ./public

lint:
	pre-commit run --all-files
