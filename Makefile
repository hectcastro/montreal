build:
	mkdir -p dist
	cp -R tmpl/css dist
	sed "s/__RATE__/$$(curl -s 'https://api.exchangerate-api.com/v4/latest/USD' | jq -r '.rates.CAD')/g" \
		tmpl/index.html.tmpl > dist/index.html

.PHONY: build
