FROM ubuntu:20.04

# Environment variables
ENV OWNER="" \
    REPO="" \
    PAT="" \
    NAME="" \
    REGISTER_ONLY=""

# Add user for github's runner
RUN useradd -m actions

# Setup timezone
ARG TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Upgrade system packages to newest versions
RUN apt update --fix-missing && apt dist-upgrade -y

# Install github's runner dependencies
RUN apt install -y \
    git \
    curl \
    jq \
    liblttng-ust0 \
    libkrb5-3 \
    zlib1g \
    libssl1.1 \
    libicu66 && \
    apt clean

# Install github's runner
USER actions
WORKDIR /home/actions
ARG GITHUB_RUNNER_VERSION="2.274.2"
RUN curl -o actions.tar.gz -L \
    "https://github.com/actions/runner/releases/download/v${GITHUB_RUNNER_VERSION}/actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz" && \
    tar -zxf actions.tar.gz && \
    rm -rf actions.tar.gz

# Entrypoint
COPY entrypoint.sh .

ENTRYPOINT ["/usr/bin/bash", "./entrypoint.sh"]
