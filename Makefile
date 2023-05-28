HUGO = hugo
PUBLIC_DIR = public

.PHONY: help
help:
	@echo "Available commands:"
	@echo "  build    : Build the site"
	@echo "  serve    : Build the site and start a local server for development"
	@echo "  clean    : Remove the generated site files"
	@echo "  help     : Print this help information"

.PHONY: build
build:
	$(HUGO)

.PHONY: serve
serve:
	$(HUGO) server -D

.PHONY: clean
clean:
	rm -rf $(PUBLIC_DIR)

.DEFAULT_GOAL := build
