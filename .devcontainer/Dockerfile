FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y dist-upgrade \
    && apt-get -y install --no-install-recommends htop vim curl git build-essential \
    libffi-dev libssl-dev libxml2-dev libxslt1-dev libjpeg8-dev libbz2-dev \
    zlib1g-dev unixodbc unixodbc-dev libsecret-1-0 libsecret-1-dev libsqlite3-dev \
    jq apt-transport-https ca-certificates gnupg-agent \
    software-properties-common bash-completion python3-pip make libbz2-dev \
    libreadline-dev libsqlite3-dev wget llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev liblzma-dev netcat direnv

# install aws stuff
RUN wget -O /tmp/awscliv2.zip "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" && \
    unzip /tmp/awscliv2.zip -d /tmp/aws-cli && \
    /tmp/aws-cli/aws/install && \
    rm tmp/awscliv2.zip && \
    rm -rf /tmp/aws-cli

# Install ASDF
RUN wget -O /tmp/asdf.tar.gz https://github.com/asdf-vm/asdf/releases/download/v0.17.0/asdf-v0.17.0-linux-amd64.tar.gz; \
    tar -xvzf /tmp/asdf.tar.gz -C /tmp/; \
    mv /tmp/asdf /usr/bin

USER vscode

ENV PATH="$PATH:/home/vscode/.asdf/shims/"

# Install ASDF plugins
RUN asdf plugin add python; \
    asdf plugin add poetry https://github.com/asdf-community/asdf-poetry.git; \
    asdf plugin add shellcheck https://github.com/luizm/asdf-shellcheck.git; \
    asdf plugin add golang https://github.com/kennyp/asdf-golang.git; \
    asdf plugin add golangci-lint https://github.com/hypnoglow/asdf-golangci-lint.git; \
    asdf plugin add actionlint;

WORKDIR /workspaces/electronic-prescription-service-get-secrets
ADD .tool-versions /workspaces/electronic-prescription-service-get-secrets/.tool-versions
ADD .tool-versions /home/vscode/.tool-versions

RUN asdf install; \
    asdf reshim python; \
    asdf reshim poetry
