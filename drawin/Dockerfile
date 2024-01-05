# FROM centos:latest as builder

# ARG target_arch=amd64
# RUN wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
# RUN ./nvim.appimage --appimage-extract

########################################
# FROM alpine:latest

# RUN apk update
# RUN apk add git

# # COPY --from=builder /squashfs-root /usr/local/nvim

# RUN apk add wget
# RUN wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
# RUN chmod 755 nvim.appimage
# RUN ./nvim.appimage --appimage-extract
# RUN mv squashfs-root /usr/local/nvim

# ENV PATH="/usr/local/nvim/usr/bin"

# ENTRYPOINT ["nvim"]


########################################
FROM centos:7.9.2009

RUN yum install -y git
RUN yum install -y wget
RUN wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
RUN chmod 755 ./nvim.appimage
RUN ./nvim.appimage --appimage-extract
RUN mv squashfs-root /usr/local/nvim

ENV PATH="/usr/local/nvim/usr/bin:${PATH}"

ENTRYPOINT ["nvim"]
