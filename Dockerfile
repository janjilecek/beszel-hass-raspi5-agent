ARG BUILD_FROM
FROM $BUILD_FROM

ARG BESZEL_VERSION
ENV BESZEL_VERSION=${BESZEL_VERSION}

WORKDIR /app

# Download binary + checksum file, verify before installing
RUN ARCH=$(uname -m | sed 's/x86_64/amd64/' | sed 's/aarch64/arm64/') && \
    BASE_URL="https://github.com/henrygd/beszel/releases/download/v${BESZEL_VERSION}" && \
    BINARY="beszel-agent_Linux_${ARCH}.tar.gz" && \
    curl -fsSL "${BASE_URL}/${BINARY}"          -o beszel-agent.tar.gz && \
    curl -fsSL "${BASE_URL}/checksums.txt"      -o checksums.txt       && \
    grep "${BINARY}" checksums.txt | sha256sum -c - && \
    tar -xz -f beszel-agent.tar.gz beszel-agent && \
    chmod +x beszel-agent && \
    rm -f beszel-agent.tar.gz checksums.txt

COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]