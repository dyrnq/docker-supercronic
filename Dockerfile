FROM debian:trixie
ARG SUPERCRONIC_VERSION
ARG TARGETARCH
ENV \
LANG=en_US.utf8 \
SUPERCRONIC_VERSION=${SUPERCRONIC_VERSION:-v0.2.41} \
SUPERCRONIC_BASE_URL=https://github.com/aptible/supercronic/releases/download

RUN set -eux; \
    apt-get update && apt-get install -y --no-install-recommends \
    vim \
    htop \
    locales \
    libfreetype6-dev \
    fontconfig \
    xz-utils \
    bzip2 \
    openssl \
    perl \
    zstd \
    jq \
    zip \
    unzip \
    ca-certificates \
    bash \
    tzdata \
    curl \
    psmisc \
    procps \
    iproute2 \
    netcat-openbsd \
    dnsutils \
    nmap \
    ncat \
    iputils-ping \
    iputils-arping \
    socat \
    openssh-client \
    tree \
    git gnupg2 p11-kit \
    && rm -rf /var/lib/apt/lists/*; \
    ARCH="${TARGETARCH:-$(uname -m)}"; \
    case "${ARCH}" in \
      amd64|x86_64) \
        SUPERCRONIC_BIN="supercronic-linux-amd64"; \
        ;; \
      arm64|aarch64) \
        SUPERCRONIC_BIN="supercronic-linux-arm64"; \
        ;; \
      *) \
        echo "Unsupported architecture: ${ARCH}"; \
        exit 1; \
        ;; \
    esac; \
    curl -fsSL "${SUPERCRONIC_BASE_URL}/${SUPERCRONIC_VERSION}/${SUPERCRONIC_BIN}" -o /usr/local/bin/supercronic; \
    chmod +x /usr/local/bin/supercronic;

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["supercronic"]
