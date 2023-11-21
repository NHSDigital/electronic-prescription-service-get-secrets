guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

.PHONY: install build test publish release clean

install: install-python install-hooks install-node

install-node:
	npm ci

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

lint: lint-go

clean:
	rm -rf ./lib

deep-clean: clean
	rm -rf .venv
	find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +

check-licenses: check-licenses-python check-licenses-go

check-licenses-python:
	./check_python_licenses.sh

check-licenses-go:
	./check_licence.sh
