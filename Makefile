PACKAGE_NAME := $(shell grep "Package:" DESCRIPTION | cut -d' ' -f2)
VERSION := $(shell grep "Version:" DESCRIPTION | cut -d' ' -f2)
R := R
RSCRIPT := Rscript

.PHONY: all build check document test lint install clean

all: build check document test lint

build:
	$(R) CMD build .

check: build
	$(R) CMD check $(PACKAGE_NAME)_$(VERSION).tar.gz

document:
	$(RSCRIPT) -e "devtools::document()"

test:
	$(RSCRIPT) -e "devtools::test()"

lint:
	$(RSCRIPT) -e "lintr::lint_package()"

install: build
	$(R) CMD INSTALL $(PACKAGE_NAME)_$(VERSION).tar.gz

clean:
	rm -rf $(PACKAGE_NAME)_$(VERSION).tar.gz
	rm -rf $(PACKAGE_NAME).Rcheck
	rm -rf man/
	rm -rf NAMESPACE

vignettes:
	$(RSCRIPT) -e "devtools::build_vignettes()"

site:
	$(RSCRIPT) -e "pkgdown::build_site()"

coverage:
	$(RSCRIPT) -e "covr::package_coverage()"

style:
	$(RSCRIPT) -e "styler::style_pkg()"

deps:
	$(RSCRIPT) -e "devtools::install_deps(dependencies = TRUE)"

dev-install:
	$(RSCRIPT) -e "devtools::install()"

release: clean document build check test lint
	@echo "Release $(VERSION) is ready"

