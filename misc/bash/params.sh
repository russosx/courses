#!/usr/bin/env bash

function exampleFunc {
	echo $1
	echo $0
	IFS="X"
	echo "$@"
	echo "$*"
}

exampleFunc "one" "two" "three"