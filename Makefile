guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

.PHONY: install build test publish release clean lint

install: install-python install-hooks

install-python:
	poetry install

install-hooks: install-python
	poetry run pre-commit install --install-hooks --overwrite

compile-go:
	./build.sh

lint-go:
	cd src && golangci-lint run

lint-githubactions:
	actionlint

lint: lint-go lint-githubactions

clean:
	rm -rf ./lib

deep-clean: clean
	rm -rf .venv
	find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +

%:
	@$(MAKE) -f /usr/local/share/eps/Mk/common.mk $@
