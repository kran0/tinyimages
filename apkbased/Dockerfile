FROM alpine:3.10 as apkextractor

ARG PACKAGES=musl
ARG ADDFILES

ADD apkextractor.sh /
RUN apk --update add ${PACKAGES}\
 && /apkextractor.sh ${PACKAGES}

FROM scratch
COPY --from=apkextractor /target /
