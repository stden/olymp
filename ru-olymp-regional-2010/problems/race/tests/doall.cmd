@echo off

javac race_gen.java
java race_gen
del race_gen.class

call tall aa
call docheck aa