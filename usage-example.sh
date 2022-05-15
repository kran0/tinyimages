#!/bin/bash -xe

# Enable bash expand aliases for non-interactive shells
shopt -s expand_aliases

# Wrapper
alias wrap='
{
 for c in $(cat); do
  alias ${TOOL_NAME:-${c}}="${CONTAINER_RUN:-podman run -i --rm} docker.io/kran0/tiny:${c}";
 done;
 unset c;
}<<<'

# Example 1: simple stdin+stdout piping
wrap 'svn xmlstarlet'
svn log https://svn.code.sf.net/p/davmail/code/trunk --limit 10 --search 'Prepare [0-9]*.[0-9]*.[0-9]* release' --xml\
 | xmlstarlet sel -T -t -m '/log/logentry[1]' -v 'concat(@revision, " " , substring-before(substring-after(msg, "Prepare "), " release"))' -n

# Example 2: Re-wrap a tool any time
wrap 'curl jq'
curl --silent https://registry.hub.docker.com/v1/repositories/kran0/tiny/tags | jq -r '.[].name'

# Example 3: Wrap a tool with special args
CONTAINER_ARGS='--entrypoint=/usr/bin/xsltproc'
TOOL_NAME='xsltproc'
wrap 'xmlstarlet'
unset CONTAINER_ARGS TOOL_NAME
xsltproc --version
