# Make container images even smaller!

Simple scripts to create very light images usefull for base-images and one-tool-images.

Please watch [usage-example.sh](./usage-example.sh).

## Add tiny images to busybox or another image

Single tool as a single layer:

```
FROM docker.io/kran0/tiny:curl as tiny
FROM docker.io/busybox:latest
COPY --from=tiny / /
```

Multiple tools as many layers:

```
FROM docker.io/kran0/tiny:curl as curl
FROM docker.io/kran0/tiny:sed as sed

FROM docker.io/busybox:latest
COPY --from=curl / /
COPY --from=sed / /
```

Multiple tools as a single layer

```
FROM docker.io/kran0/tiny:curl as curl
FROM docker.io/kran0/tiny:sed as sed
FROM scratch as tiny
COPY --from=curl / /
COPY --from=sed / /

FROM docker.io/busybox:latest
COPY --from=tiny / /
```

# Automated builds

[![Builds][badge_build_status]][link_docker_tags]

Feel free add more tools by asking me or sending PR's

| Repository:Tag                  | Description                                                         |
|:--------------------------------|---------------------------------------------------------------------|
| docker.io/kran0/tiny:curl       | [Transfer data specified with URL](https://github.com/curl/curl)    |
| grep                            | [GNU Grep](http://www.gnu.org/software/grep/)                       |
| docker.io/kran0/tiny:jq         | [JSON processor](https://github.com/stedolan/jq)                    |
| perl, perl-utils                | [Perl](https://www.perl.org/)                                       |
| sed                             | [GNU Sed](https://www.gnu.org/software/sed/)                        |
| docker.io/kran0/tiny:socat      | [Multipurpose relay](http://www.dest-unreach.org/socat/)            |
| docker.io/kran0/tiny:svn        | [Subversion version control client](https://subversion.apache.org/) |
| docker.io/kran0/tiny:tor        | [The Onion Router](https://github.com/torproject/tor)               |
| docker.io/kran0/tiny:xmlstarlet | [Utilities for XML](http://xmlstar.sourceforge.net/)                |

---
[badge_build_status]:https://github.com/kran0/tinyimages/actions/workflows/build_images.yml/badge.svg
[link_docker_tags]:https://hub.docker.com/r/kran0/tiny/tags?page=1&ordering=last_updated
