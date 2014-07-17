#!/usr/bin/env bash

function isDivisableBy {
	return $(($1%$2))
}

for number in {1..100}; do
	output=""
	if isDivisableBy $number 3; then
		output="Fizz"
	fi
	if isDivisableBy $number 5; then
		output="${output}Buzz"
	fi
	if [ -z $output ]; then
		echo $number
	else
		echo $output;
	fi
done