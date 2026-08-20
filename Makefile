build:
	mkdir -p dist
	mise exec -- elm make src/Main.elm --optimize --output=dist/elm.js
	cp index.html dist/
	cp -R assets dist/

format:
	mise exec -- elm-format --yes src/ review/src/

lint:
	mise exec -- elm-format --validate src/ review/src/
	mise exec -- elm-review

.PHONY: build format lint
