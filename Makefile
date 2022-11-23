CONTEXTS = $(shell find ./ -type d -maxdepth 1 -mindepth 1 -not -path "*/.git*" -not -path "*/diagrams*" -exec basename {} \;)

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
