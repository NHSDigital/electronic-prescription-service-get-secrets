guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

.PHONY: install build test publish release clean lint

install: install-python install-hooks install-go

install-python:
	poetry install

install-go:
	cd src && go mod vendor

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

check-licenses: check-licenses-python check-licenses-go

check-licenses-python:
	scripts/check_python_licenses.sh

check-licenses-go:
	scripts/check_go_licenses.sh
