WORKING_DIR := $(shell pwd)

.DEFAULT_GOAL := helm-render

.PHONY: helm-render

helm-install:: ## installs using helm from chart in repo
		@helm install \
			-f helm-values.yaml \
				revprox charts/revprox

helm-upgrade:: ## upgrades deployed helm release
		@helm upgrade \
			-f helm-values.yaml \
				revprox charts/revprox

helm-uninstall:: ## deletes and purges deployed helm release
		@helm uninstall \
				revprox

helm-render:: ## prints out the rendered chart
		@helm install \
			-f helm-values.yaml \
			--dry-run \
			--debug \
				revprox charts/revprox

helm-validate:: ## runs a lint on the helm chart
		@helm lint \
			-f helm-values.yaml \
				charts/revprox

# a help target including self-documenting targets (see the awk statement)
define HELP_TEXT
Usage: make [TARGET]... [MAKEVAR1=SOMETHING]...

Available targets:
endef
export HELP_TEXT
help: ## this help target
	@cat .banner
	@echo
	@echo "$$HELP_TEXT"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
		{printf "\033[36m%-30s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)
