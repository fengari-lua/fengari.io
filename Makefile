all: static/js/fengari-web.js

serve: all
	lapis server production

fengari-web/dist/fengari-web.js: fengari-web/
	(cd fengari-web && yarn install);

static/js/fengari-web.js: fengari-web/dist/fengari-web.js
	install -m 644 -D "$<" "$@"

.PHONY: all serve
