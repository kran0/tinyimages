FROM alpine:3.8 as apkextractor

ARG PACKAGES=socat

ADD apkextractor.sh /
RUN apk --update add ${PACKAGES}\
 && /apkextractor.sh ${PACKAGES}

FROM scratch
COPY --from=apkextractor /target /
