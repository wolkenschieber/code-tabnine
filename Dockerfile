FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

ARG DEBIAN_FRONTEND=noninteractive

LABEL build_version="Visual Studio Code using Tabnine"
LABEL maintainer="wolkenschieber"

ENV TITLE='Visual Studio Code with Tabnine'

RUN \
  # Workaround to install Java
  mkdir -p /usr/share/man/man1 \
  && apt-get update \
  # Install browser and dependencies
  && apt-get install -y --no-install-recommends \
  curl firefox-esr git openjdk-17-jdk \
  # Clean up
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
  && chmod 4755 /opt/VSCode-linux-x64/chrome-sandbox \
  # Extension Pack for Java
  && /opt/VSCode-linux-x64/bin/code --user-data-dir /config/.vscode --install-extension vscjava.vscode-java-pack \
  # ShellCheck
  && /opt/VSCode-linux-x64/bin/code --user-data-dir /config/.vscode --install-extension timonwong.shellcheck \
  # TabNine 
  && /opt/VSCode-linux-x64/bin/code --user-data-dir /config/.vscode --install-extension TabNine.tabnine-vscode \
  # Final step: Fix permissions
  && chown -R abc:abc /config/.vscode \
  # Clean up
  && rm -rf \
  /config/.cache \
  /var/lib/apt/lists/* \
  /var/tmp/* \
  /tmp/* 

COPY /root /

EXPOSE 3000

VOLUME /config