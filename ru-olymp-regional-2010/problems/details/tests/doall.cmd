@echo off

javac details_gen.java
java details_gen
del details_gen.class

call tall aa
call docheck aa