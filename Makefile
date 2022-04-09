ROOT := $(shell pwd)

build: cv.tex
	docker compose run --rm devtools xelatex \
 		-halt-on-error \
 		-interaction=errorstopmode \
 		cv.tex

lock-image-digests:
	docker compose run --rm docker-lock lock generate
	docker compose run --rm docker-lock lock rewrite

verify-image-digests:
	docker compose run --rm docker-lock lock verify
