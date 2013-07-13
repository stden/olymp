@echo off

javac numbers_gen.java
java numbers_gen
del numbers_gen.class

call tall aa
call docheck aa