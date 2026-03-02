ARG BUILD_FROM
FROM $BUILD_FROM

ARG BESZEL_VERSION
ENV BESZEL_VERSION=${BESZEL_VERSION}

WORKDIR /app

RUN ARCH=$(uname -m | sed 's/x86_64/amd64/' | sed 's/aarch64/arm64/') && \
    BASE_URL="https://github.com/henrygd/beszel/releases/download/v${BESZEL_VERSION}" && \
    BINARY="beszel-agent_linux_${ARCH}.tar.gz" && \
    CHECKSUMS="beszel_${BESZEL_VERSION}_checksums.txt" && \
    curl -fsSL "${BASE_URL}/${BINARY}"     -o "${BINARY}"    && \
    curl -fsSL "${BASE_URL}/${CHECKSUMS}"  -o checksums.txt  && \
    grep "${BINARY}" checksums.txt | sha256sum -c -          && \
    tar -xzf "${BINARY}" beszel-agent                        && \
    chmod +x beszel-agent                                         && \
    echo "${BESZEL_VERSION}" > /app/BESZEL_VERSION                && \
    rm -f "${BINARY}" checksums.txt

COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]