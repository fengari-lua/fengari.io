all: static/js/fengari-web.js

serve: all
	lapis server production

static/js/fengari-web.js:
	curl -L https://github.com/fengari-lua/fengari-web/releases/download/v0.1.0/fengari-web.js -o $@

.PHONY: all serve
