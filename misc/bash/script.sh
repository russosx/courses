#!/usr/bin/env bash

function isDivisableBy {
	return $(($1%$2))
}

function FizzOrBuzz {
    output=""
#    if isDivisableBy $1 3; then
#        output="Fizz"
#    fi
#    if isDivisableBy $1 5; then
#        output="Buzz"
#    fi
    isDivisableBy $1 3 && output="Fizz"
    isDivisableBy $1 5 && output="${output}Buzz"
    if [ -z $output ]; then
        echo $1
    else
        echo $output
    fi
}

for number in {1..100}; do
    echo "-`FizzOrBuzz $number`"
#    fizzBuzzer=$(FizzOrBuzz $number)
#    echo "-${fizzBuzzer}"
done