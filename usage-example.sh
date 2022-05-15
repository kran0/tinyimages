#!/bin/bash

# Enable bash expand aliases for non-interactive shells
shopt -s expand_aliases

# Wrapper
alias wrap='{
 for c in $(cat); do
  alias ${c}="${CONTAINER_RUN:-podman run -i --rm} docker.io/kran0/tiny:${c}";
 done;
 unset c;
}<<<'

# Do wrap tools
wrap 'socat tor svn jq xmlstarlet'

# Call the tools
# Ex1: Simple stdin+stdout piping
svn log https://svn.code.sf.net/p/davmail/code/trunk --limit 10 --search 'Prepare [0-9]*.[0-9]*.[0-9]* release' --xml\
 | xmlstarlet sel -T -t -m '/log/logentry[1]' -v 'concat(@revision, " " , substring-before(substring-after(msg, "Prepare "), " release"))' -n
