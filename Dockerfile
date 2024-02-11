FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

ARG DEBIAN_FRONTEND=noninteractive

LABEL build_version="Visual Studio Code using Tabnine"
LABEL maintainer="wolkenschieber"

ENV TITLE='Visual Studio Code with Tabnine'

RUN \
  mkdir -p /usr/share/man/man1 \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    curl chromium chromium-l10n git openjdk-17-jdk \ 
  && apt-get autoclean \
  && rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/* 

RUN \
    curl -SL -o /tmp/vs-code.tar.gz 'https://code.visualstudio.com/sha/download?build=stable&os=linux-x64' \
  && tar xf /tmp/vs-code.tar.gz -C /opt \
  && chown root:root /opt/VSCode-linux-x64/chrome-sandbox \
  && chmod 4755 /opt/VSCode-linux-x64/chrome-sandbox

RUN \
  # Extension Pack for Java
  /opt/VSCode-linux-x64/bin/code --user-data-dir /config/.vscode --install-extension vscjava.vscode-java-pack \
  # ShellCheck
  && /opt/VSCode-linux-x64/bin/code --user-data-dir /config/.vscode --install-extension timonwong.shellcheck \
  # TabNine 
  && /opt/VSCode-linux-x64/bin/code --user-data-dir /config/.vscode --install-extension TabNine.tabnine-vscode \
  # Final step: Fix permissions
  && chown -R abc:abc /config/.vscode

COPY /root /

EXPOSE 3000

VOLUME /config