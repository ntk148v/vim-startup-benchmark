FROM alpine:latest
LABEL maintainer="Kien Nguyen-Tuan <kiennt2609@gmail.com>"
RUN apk add --no-cache lua5.3 neovim git curl ca-certificates
RUN adduser --disabled-password --gecos '' vimuser && \
    echo "ALL            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers
WORKDIR /home/vimuser
USER vimuser
# Setup package managers
COPY install.sh install.sh
COPY src src
RUN bash install.sh
