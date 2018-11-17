FROM alpine:3.8 as apkextractor

ARG PACKAGES=socat

ADD rootfs /
RUN apk --update "${PACKAGES}"\
 && /apkextractor.sh "${PACKAGES}"

FROM scratch
COPY --from apkextractor /target /
