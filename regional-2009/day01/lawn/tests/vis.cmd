@echo off
call javac Visualizer.java
for %%i in (??) do (
  echo visualizing %%i...
  call java Visualizer %%i
)
del Visualizer*.class
start 01.bmp