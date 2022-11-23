# CONTEXTS = $(shell find ./ -type d -maxdepth 1 -mindepth 1 -exec basename {} \;)
# CONTEXTS = $(shell find ./ -type d -maxdepth 1 -mindepth 1 d -name .git -exec basename {} \;)
# CONTEXTS = $(shell find ./ -type d -maxdepth 1 -mindepth 1 -not \( -path "*/.git/*" -prune \) -exec basename {} \;)
CONTEXTS = $(shell find ./ -type d -maxdepth 1 -mindepth 1 -not -path "*/.git*" -exec basename {} \;)
# 									find -not \( -path ./.git -prune \) -type f

$(addprefix test-, $(CONTEXTS)):
	@make -C $(subst test-,,$@) test

$(addprefix install-, $(CONTEXTS)):
	@make -C $(subst test-,,$@) test

install:
	$(addprefix install-, $(CONTEXTS))

test: $(addprefix test-, $(CONTEXTS))

help:
	@echo "test"
	@echo "install"

.DEFAULT_GOAL := help
