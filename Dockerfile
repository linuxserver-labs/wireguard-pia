FROM scratch

LABEL maintainer="GilbN"
LABEL app="wireguard-pia"
#copy local files.
COPY root/ /