FROM debian:bookworm

RUN apt-get update

RUN apt-get install -y \
    build-essential \
    libncurses-dev \
    rsync \
    unzip \
    bc \
    wget \
    cpio \
    python3 \
    file \
    locales \
    perl \
    git

RUN groupadd -g 1000 builder && \
    useradd -u 1000 -g builder -m builder

USER builder