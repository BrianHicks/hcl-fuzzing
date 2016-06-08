#!/usr/bin/env bash
CRASH=$1

cat <<EOF
I've found a crashing input in HCL as of $(cd ~/code/go/src/github.com/hashicorp/hcl; git rev-parse HEAD). Here's an [SSCCE](http://www.sscce.org/) demonstrating the problem.

\`\`\`go
package main

import (
	"github.com/hashicorp/hcl"
)

var (
	data = $(cat $1.quoted)
)

func main() {
	var out interface{}
	hcl.Unmarshal([]byte(data), &out)
}
\`\`\`

When run, this gives the following output:

\`\`\`
$(cat $1.output)
\`\`\`

(and here it is when run through panicparse, for convenience)

\`\`\`
$(cat $1.output | panicparse)
\`\`\`
EOF
