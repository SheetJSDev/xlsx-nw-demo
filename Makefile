app.nw: index.html package.json
	npm install xlsx
	zip $@ $^

.PHONY: test
test: app.nw
	nw $< $(shell pwd)/test.xlsx
