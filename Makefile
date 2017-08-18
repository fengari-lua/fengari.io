all: static/js/fengari-web-cli.js

serve: all
	lapis server production

fengari-web-cli/dist/fengari-web-cli.js: fengari-web-cli/
	(cd fengari-web-cli && yarn install && webpack -p);

static/js/fengari-web-cli.js: fengari-web-cli/dist/fengari-web-cli.js
	install -m 644 -D "$<" "$@"

.PHONY: all serve
