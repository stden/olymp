#!/bin/bash

problem=python
author=at
lang=py

echo Generating tests...
rm -r tests 2>/dev/null
mkdir tests 2>/dev/null
pushd src
javac Tests.java || { echo "Failed to compile test generator"; exit 1; }
java Tests || { echo "Failed to generate tests"; exit 1; }
popd

echo Compiling checker...
rm -rf __tmp 2>/dev/null
mkdir __tmp 2>/dev/null
javac -classpath "../../lib/testlib4j.jar" -sourcepath . -d __tmp Check.java || { echo "checker compilation failed"; exit 1; }
cp ../../lib/testlib4j.jar __tmp
pushd __tmp
jar xf testlib4j.jar
echo Main-Class: ru.ifmo.testlib.CheckerFramework> META-INF/manifest.1
echo Checker-Class: Check>> META-INF/manifest.1
rm -r *.java 2>/dev/null
rm testlib4j.jar 2>/dev/null
jar cfm check.jar META-INF/manifest.1 *.class ru
cp check.jar ..
popd

rm -rf __tmp 2>/dev/null
if [ -e Validate.java ]; then
	rm -rf __tmp 2>/dev/null	
	mkdir __tmp
	javac -sourcepath . -d __tmp Validate.java
	pushd __tmp
	mkdir META-INF
	echo Main-Class: Validate> META-INF/manifest.1
	jar cfm validate.jar META-INF/manifest.1 *.class
	cp validate.jar ..
	popd
	rm -rf __tmp 2>/dev/null
fi;

echo Generating answers

if [[ $lang == java ]]; then
	javac ${problem}_$author.java -encoding utf-8
fi;

if [[ $lang == cpp ]]; then
	g++ ${problem}_$author.cpp -o $problem_$author.exe -O2 -Wall -Wextra -Wall
fi;

for i in `ls tests/??`; do 
	echo Test $i
	cp $i ${problem}.in
	if [ -e validate.jar ]; then
		java -jar validate.jar <${problem}.in || { echo "Validator rejectes tests $i"; exit 1; }
		echo "Validator accepts test $i"
	fi;
	if [[ $lang == java ]]; then java ${problem}_$author; fi;
	if [[ $lang == cpp  ]]; then ./${problem}_$author; fi;
	if [[ $lang == py ]]; then python3 ${problem}_$author.py; fi;


	cp ${problem}.out $i.a
	echo Check $i
	java -jar check.jar $i $i.a $i.a || { echo "Checker failed on test $i"; exit 1; }

done;
