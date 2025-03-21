HUGO = hugo
PUBLIC_DIR = public

.PHONY: help
help:
	@echo "Available commands:"
	@echo "  build    : Build the site"
	@echo "  serve    : Build the site and start a local server for development"
	@echo "  new      : Create new post
	@echo "  clean    : Remove the generated site files"
	@echo "  help     : Print this help information"

.PHONY: build
build:
	$(HUGO)

.PHONY: serve
serve:
	$(HUGO) server -D

.PHONY: new
new:
	@read -p "Enter the name of the new post: " name; \
	hugo new -k default -c "./content/posts/" "$${name}.md"

.PHONY: clean
clean:
	rm -rf $(PUBLIC_DIR)

.DEFAULT_GOAL := build
