FROM debian:bullseye

MAINTAINER Fabian Baena

# ---- Config ----
ARG KOHA_VERSION=23.11
ARG PKG_URL=https://debian.koha-community.org/koha

ENV DEBIAN_FRONTEND=noninteractive

# ---- Base tools ----
RUN apt-get update && \
    apt-get install -y --fix-missing \
      wget \
      gnupg \
      ca-certificates \
      apt-transport-https && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# ---- Koha GPG ----
RUN wget -q -O- https://debian.koha-community.org/koha/gpg.asc | apt-key add -

# ---- Koha repo ----
RUN echo "deb ${PKG_URL} ${KOHA_VERSION} main" | tee /etc/apt/sources.list.d/koha.list

# ---- Install Koha ----
RUN apt-get update && \
    apt-get install -y --fix-missing --no-install-recommends \
        koha-common && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# ---- Apache mods ----
RUN a2enmod rewrite headers proxy_http cgi && \
    a2dissite 000-default

# ---- Runtime ----
RUN mkdir /docker

COPY entrypoint.sh /docker/
COPY templates /templates
COPY backupdb/init.sql /docker/init.sql

RUN chmod +x /docker/entrypoint.sh

ENTRYPOINT ["/docker/entrypoint.sh"]
