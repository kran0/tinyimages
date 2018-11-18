
include(`Dockerfile-apkbase.m4')

ENTRYPOINT [ "/usr/bin/socat" ]
CMD [ "--help" ]
