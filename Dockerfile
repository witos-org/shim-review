FROM debian:trixie-20260623

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential ca-certificates wget git

RUN mkdir /shim-review
COPY shimx64.efi /shim-review
WORKDIR /

RUN wget https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2
RUN echo "46319cd228d8f2c06c744241c0f342412329a7c630436fce7f82cf6936b1d603  shim-16.1.tar.bz2" > SHA256SUM
RUN sha256sum -c < SHA256SUM

RUN mv shim-16.1.tar.bz2 shim_16.1.orig.tar.bz2
run git clone https://git.witine.com/witos/shim.git
WORKDIR /shim
RUN git checkout witos/16.1-2_wit1
RUN ls -lha
RUN apt-get build-dep -y .
RUN dpkg-buildpackage -us -uc
WORKDIR /

RUN echo "=== SHA-256 ===" && \
    sha256sum /shim/shimx64.efi /shim-review/shimx64.efi

RUN hexdump -Cv /shim/shimx64.efi > build && \
    hexdump -Cv /shim-review/shimx64.efi > orig
RUN echo "=== Reproducibility ==="; \
    if diff -u build orig; then \
        echo "PASS: shimx64.efi is byte-for-byte reproducible"; \
    else \
        echo "FAIL: shimx64.efi differs"; \
        exit 1; \
    fi

RUN echo "=== SBAT ===" && \
    objcopy --dump-section .sbat=/dev/stdout /shim-review/shimx64.efi

RUN echo "=== NX ===" && /shim/debian/check_nx /shim-review/shimx64.efi
