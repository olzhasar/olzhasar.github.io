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
	slug=$$(echo "$$name" | iconv -t ascii//TRANSLIT | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$$//g'); \
	file="./content/posts/$${slug}.md"; \
	hugo new -k default -c "./content/posts/" "$${slug}.md" && \
	sed -i '' "s/^title: .*/title: \"$${name}\"/" "$${file}"

.PHONY: clean
clean:
	rm -rf $(PUBLIC_DIR)

.DEFAULT_GOAL := build
