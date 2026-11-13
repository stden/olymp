#!/bin/bash

function CompSourseError {
	echo "Cannot compile source"
	exit 1
}

function CompRunningError {
	echo "Fail in running on tests"
	exit 1
}

problem=python
author=$1
lang=$2

if [[ $1 == "" || $2 == "" ]]; then
	echo "No parameters"
	exit 1;
fi;

exec="echo No execution command"
echo Compiling solution

if [[ $lang == dpr ]]; then
	echo "Pascal is not supported."
	exit 1;
else if [[ $lang == cpp ]]; then
	g++ ${problem}_$author.cpp -o ${problem}_$author.exe -O2 -Wall || CompSourseError;
	exec="./${problem}_$author.exe"
else if [ $lang == java ]; then
	javac ${problem}_$author.java || CompSourseError;
	exec="java ${problem}_$author"
else if [ $lang == py ]; then
	exec="python3 ${problem}_$author.py"
fi;fi;fi;fi;
echo exec $exec
checker=""
if [ ! -e check.jar ]; then 
	echo "No checker"
	exit 1;
else
	checker="java -jar check.jar"
fi;

echo Checking solution

for i in `ls tests/??`; do 
	echo Testing on test $i
	rm ${problem}.out 2>/dev/null
	cp $i ${problem}.in
	$exec || { echo "RE on test $i"; exit 1; };
	$checker ${problem}.in $problem.out $i.a || { echo "WA on test $i"; exit 1; };
	echo OK;
done;
