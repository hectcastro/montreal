build:
	mkdir -p dist
	cp -R tmpl/css dist
	minijinja-cli tmpl/index.html.j2 \
		-D "rate=$(shell rates 1 USD to CAD --short)" > dist/index.html

install:
	cargo install \
		minijinja-cli \
		rates

.PHONY: build install
