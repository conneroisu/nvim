# -include .env
#  file: Makefile
#  url: https://github.com/conneroisu/nvim/blob/main/Makefile
#  description: Makefile for the project

export MAKEFLAGS += --always-make --print-directory
SHELLFLAGS = -e
.PHONY: test
test:
	@+sh ./scripts/makefile.test.sh

.PHONY: dev.requirements
dev.requirements:
	@sh ./scripts/makefile.dev.requirements.sh

.PHONY: install
clean:
	@sh ./scripts/makefile.install.sh

