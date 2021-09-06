FROM phusion/baseimage:master

MAINTAINER Docker Maintenance <docker-maint@dotmpe.com>

# Upgrade with apt-get
# Then install minimal user tools
RUN \
  DEBIAN_FRONTEND=noninteractive; RUNLEVEL=1; \
  apt-get update -qqy && \
  apt-get upgrade -qqy -o Dpkg::Options::="--force-confold" && \
  apt-get install -qqy --allow-downgrades \
    dash apt-transport-https bc wget curl git man jq ssh sudo tmux tree \
    uuid-runtime vim && \
  \
  cd /tmp && wget --quiet --content-disposition \
    "https://github.com/git-hooks/git-hooks/releases/download/v1.1.4/git-hooks_linux_amd64.tar.gz" && \
  tar xf git-hooks_linux_amd64.tar.gz && \
  mv build/git-hooks_linux_amd64 /usr/local/bin/git-hooks && \
  rm -rf build git-hooks_linux_amd64.tar.gz && \
  \
  apt-get clean autoclean && \
  apt-get autoremove -qqy && \
  unset DEBIAN_FRONTEND RUNLEVEL && \
  DEBIAN_FRONTEND=teletype \
  rm -Rf /usr/local/src/* -Rf && \
  rm -Rf /tmp/* && \
  rm -Rf /var/lib/apt/lists/*.gz && \
  rm -Rf /var/lib/cache/* && \
  rm -Rf /var/lib/log/* && \
  rm -Rf /var/log/* && \
  rm -Rf /var/cache/*

RUN locale-gen en_US.UTF-8

#
