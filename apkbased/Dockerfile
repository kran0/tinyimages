FROM alpine:3.8 as apkextractor

ARG PACKAGES=socat
ARG AFTERRUN="echo DUMMY"

ADD apkextractor.sh /
RUN apk --update add ${PACKAGES}\
 && /apkextractor.sh ${PACKAGES}\
 && ${AFTERRUN}

FROM scratch as stage1
COPY --from=apkextractor /target /
