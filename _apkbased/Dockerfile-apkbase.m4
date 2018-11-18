FROM alpine:3.8 as apkextractor

ARG PACKAGES=socat

ADD https://github.com/kran0/tinyimages/raw/master/rootfs/apkextractor.sh /
RUN apk --update "${PACKAGES}"\
 && chmod +x /apkextractor.sh
 && /apkextractor.sh "${PACKAGES}"

FROM scratch
COPY --from apkextractor /target /
