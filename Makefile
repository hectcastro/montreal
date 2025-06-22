build:
	mkdir -p dist
	cp -R tmpl/css dist
	minijinja-cli tmpl/index.html.j2 \
		-D "rate=$(shell curl -s 'https://api.exchangerate-api.com/v4/latest/USD' | jq '.rates.CAD')" > dist/index.html

install:
	cargo install \
		minijinja-cli

.PHONY: build install
