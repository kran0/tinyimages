# Make container images even smaller!

Simple scripts to create very light images usefull for base-images and one-tool-images.

Please watch [usage-example.sh](./usage-example.sh).

# Automated builds

[![Builds][badge_build_status]][link_docker_tags]

| Repository:Tag                  | Description                                                         |
|:--------------------------------|---------------------------------------------------------------------|
| docker.io/kran0/tiny:socat      | [Multipurpose relay](http://www.dest-unreach.org/socat/)            |
| docker.io/kran0/tiny:tor        | [The Onion Router](https://github.com/torproject/tor)               |
| docker.io/kran0/tiny:svn        | [Subversion version control client](https://subversion.apache.org/) |
| docker.io/kran0/tiny:jq         | [JSON processor](https://github.com/stedolan/jq)                    |
| docker.io/kran0/tiny:xmlstarlet | [Utilities for XML](http://xmlstar.sourceforge.net/)                |
| docker.io/kran0/tiny:curl       | [Transfer data specified with URL](https://github.com/curl/curl)    |

---
[badge_build_status]:https://github.com/kran0/tinyimages/actions/workflows/build_images.yml/badge.svg
[link_docker_tags]:https://hub.docker.com/r/kran0/tiny/tags?page=1&ordering=last_updated
