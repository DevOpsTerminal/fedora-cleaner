.PHONY: all install uninstall test clean build package release docs serve

# Variables
NAME = fedora-cleaner
VERSION = $(shell git describe --tags --always --dirty)
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man/man1
DOCDIR = $(PREFIX)/share/doc/$(NAME)

# Detect Linux distribution
DISTRO_ID = $(shell . /etc/os-release && echo $$ID)
DISTRO_VERSION = $(shell . /etc/os-release && echo $$VERSION_ID)

# Installation paths
BIN = $(NAME).sh
MAN = $(NAME).1
DOCS = README.md LICENSE

# Build targets
all: build

# Install for the detected distribution
install: install-$(DISTRO_ID)

install-fedora install-rhel install-centos:
	@echo "Installing for Fedora/RHEL/CentOS..."
	install -Dm755 $(BIN) $(DESTDIR)$(BINDIR)/$(NAME)
	install -Dm644 $(MAN) $(DESTDIR)$(MANDIR)/$(NAME).1
	install -Dm644 $(DOCS) $(DESTDIR)$(DOCDIR)/
	@echo "Installation complete. Run '$(NAME) --help' to get started."

install-debian install-ubuntu:
	@echo "Installing for Debian/Ubuntu..."
	install -Dm755 $(BIN) $(DESTDIR)$(BINDIR)/$(NAME)
	install -Dm644 $(MAN) $(DESTDIR)$(MANDIR)/$(NAME).1
	install -Dm644 $(DOCS) $(DESTDIR)$(DOCDIR)/
	@echo "Installation complete. Run '$(NAME) --help' to get started."

install-arch:
	@echo "Installing for Arch Linux..."
	install -Dm755 $(BIN) $(DESTDIR)$(BINDIR)/$(NAME)
	install -Dm644 $(MAN) $(DESTDIR)$(MANDIR)/$(NAME).1
	install -Dm644 $(DOCS) $(DESTDIR)$(DOCDIR)/
	@echo "Installation complete. Run '$(NAME) --help' to get started."

# Default installation for other distributions
install-:
	@echo "Installing for generic Linux..."
	install -Dm755 $(BIN) $(DESTDIR)$(BINDIR)/$(NAME)
	install -Dm644 $(MAN) $(DESTDIR)$(MANDIR)/$(NAME).1
	install -Dm644 $(DOCS) $(DESTDIR)$(DOCDIR)/
	@echo "Installation complete. Run '$(NAME) --help' to get started."

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/$(NAME)
	rm -f $(DESTDIR)$(MANDIR)/$(NAME).1
	test -d $(DESTDIR)$(DOCDIR) && rm -rf $(DESTDIR)$(DOCDIR) || true

# Build documentation
docs:
	@echo "Building documentation..."
	@pandoc -s -t man $(NAME).1.md -o $(NAME).1
	@echo "Documentation built: $(NAME).1"

# Build package
package: docs
	@echo "Building package..."
	@mkdir -p dist
	@tar czf dist/$(NAME)-$(VERSION).tar.gz --transform 's,^,$(NAME)-$(VERSION)/,' \
		$(BIN) $(MAN) $(DOCS) Makefile
	@echo "Package built: dist/$(NAME)-$(VERSION).tar.gz"

# Release helper (requires GitHub CLI)
release: test package
	@echo "Creating release v$(VERSION)..."
	gh release create v$(VERSION) dist/$(NAME)-$(VERSION).tar.gz --title "v$(VERSION)" --notes "Release v$(VERSION)"

# Run tests
test:
	@echo "Running tests..."
	shellcheck $(BIN)
	@echo "All tests passed!"

# Clean build artifacts
clean:
	rm -f $(NAME).1
	rm -rf dist/

# Run development server for docs
serve:
	bundle exec jekyll serve --livereload

# Help
dist: package

help:
	@echo "Available targets:"
	@echo "  install    - Install the program"
	@echo "  uninstall  - Uninstall the program"
	@echo "  test       - Run tests"
	@echo "  clean      - Remove build artifacts"
	@echo "  docs       - Build documentation"
	@echo "  package    - Create distribution package"
	@echo "  release    - Create a new release (requires GitHub CLI)"
	@echo "  serve      - Run local development server for docs"

.DEFAULT_GOAL := help
