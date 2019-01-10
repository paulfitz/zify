# This creates an image that is good enough for running 2d3d

FROM ubuntu:18.04

# enough for main message
RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends blender imagemagick fontforge potrace && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir /app

WORKDIR /app
