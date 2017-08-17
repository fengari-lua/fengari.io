all: static/js/fengari-web-cli.js

serve: all
	lapis server production

fengari-web-cli/dist/fengari-web-cli-lua.js: fengari-web-cli/
	(cd fengari-web-cli && yarn install && webpack);

static/js/fengari-web-cli.js: fengari-web-cli/dist/fengari-web-cli-lua.js
	install -m 644 -D fengari-web-cli/dist/fengari-web-cli-lua.js "$@"

.PHONY: all serve
