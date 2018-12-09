FROM alpine:3.8 as apkextractor

ARG PACKAGES=socat

ADD apkextractor.sh /
RUN apk --update add ${PACKAGES}\
 && /apkextractor.sh ${PACKAGES}

FROM scratch as stage1
COPY --from=apkextractor /target /
