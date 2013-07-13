@echo off
rem Lets check if command processor supports extensions that we need
rem Also make all environment variable changes local and enable delayed expansion 
verify other 2> nul
setlocal enableextensions 
if errorlevel 1 goto unsupported
goto proceed
:unsupported
echo COMMAND EXTENSIONS ARE NOT AVAILABLE. 
echo TEST TOOL WILL NOW TERMINATE.
goto terminate

:proceed
set tcmd=%0

if /i "%1" == "build" goto build
if /i "%1" == "check" goto check
if /i "%1" == "xml" goto xml
if /i "%1" == "pcms" goto pcms
if /i "%1" == "clean" goto clean
if /i "%1" == "make" goto make
if /i "%1" == "run" goto run
if /i "%1" == "time" goto time
if /i "%1" == "help" goto help
if /i "%1" == "" goto shorthelp

echo Unrecognized command "%1".
echo Use "t help | more" for help.
exit /b

rem --------------------------------- HELP ---------------------------------

:shorthelp
echo TEST TOOL. (C) Roman Elizarov, 2004
echo Use "t help | more" for help.
exit /b

:help
echo =========================================================================
echo TEST TOOL. (C) Roman Elizarov, 2004
echo Usage: t [^<subcommand^> [^<arguments^>...]]
echo "t help" shows this help. Other available subcommands are:
echo build, check, xml, pcms, clean, make, run, time 
echo (case is not important for subcommands).
echo . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
echo DIRECTORY STRUCTURE
echo Test tool assumes that each directory with problem has "tests"
echo subdirectory with test files that are named 01, 02, 03,..., 99.
echo Alternatively, instead of "XX" test file it may contain "doXX.dpr"
echo file that prints to the console contents of the corresponding test.
echo Alternatively, it may contain "doall.*" instead of all tests
echo "doall" shall create ALL test files and may assume that it is being 
echo called from the tests directory.
echo . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
echo Answer files are placed into "XX.a" files after build. They are 
echo generated by running a specified model solution.
echo . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
echo Build, check, and clean subcommands may be used from the top-level
echo directory. They always recursively scan subdirectories for problem
echo directories and perform their task for each problem.
echo . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
echo SPECIFYING SOLUTION
echo Build and check subcommands accept solution as their first and only
echo argument. Source or executable file with solution may be explicitly
echo specified (see make subcommand for a list of supported extensions).
echo For example, "t build solution.dpr" will build answer files using
echo "solution.dpr". Suffix for the solution name may be specified
echo instead. In this case, problem and underscore are appended before the
echo specified suffix. For example, "t build re.dpr" for problem called
echo "box" will generate answers using "box_re.dpr". Extension may be
echo omitted in the suffix, so the last command may be shortened to just
echo "t build re". Combined with recursive behavior one can run it in the
echo top-level directory to check all problems with solutions that have
echo "re" suffix. If solution is omitted entirely, then problem name is
echo used instead. For example "t build" for problem called "box" will
echo generate answer using "box.dpr", or "box.java", or "box.cpp", etc if
echo one of the corresponding files exits.
echo . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
echo BUILD
echo Usage: t build [^<solution^> [^<tests^>...]]
echo Builds test files and answer files. It creates "build.log" file
echo where outcome for each test is listed (one test on a line). If
echo solution is not found, then answer files are not generated. Works
echo for all available tests unless the the list of tests is explicitly 
echo specified. When all tests are being built it also compiles checker
echo program named "check" if it exists.
echo . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
echo CHECK
echo Usage: t check [^<solution^> [^<tests^>...]]
echo Checks specified solution. It creates "check.log" file where outcome
echo for each test is listed (one test on a line). Checker program shall be
echo named "check" and shall accept "input output answer" arguments in this
echo order. Works with all available tests unless the list of tests is 
echo explicitly specified.
echo . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
echo XML
echo Usage: t xml [^<prefix^> [^<time-limit^> [^<memory-limit^>]]]
echo Builds "problem.xml", so that problem can be used with PCMS2-v2
echo contest management system. You must successfully use build subcommand
echo before using xml subcommand. Prefix is prepended to problem identifiers
echo (default is empty). Default time limit is 2s, memory limit 67108864.
echo . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
echo PCMS
echo Usage: t pcms
echo Copies all PCMS configuration files (problem.xml, tests, checker) into a 
echo separate directory. You must "build" and "xml" first.
echo . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
echo CLEAN
echo Usage: t clean
echo Cleans all auxiliary files that might have been created during build,
echo xml, and check operations.
echo . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
echo MAKE
echo Usage: t make ^<srcfile^>
echo Makes the specified source file. Supported extensions are .drp, .java,
echo .cpp, .c, .cmd, .exe. In the later cases (.cmd, .exe extensions) make 
echo just silently quits. Extension may be entirely omitted. In this case make 
echo will try echo to find the file by attaching extensions in the order they 
echo are listed above. For example, "t make solution" will compile "solution.dpr"
echo file (if it exits) using Borland Delphi. During compilation it includes
echo "..\testlib" directory (relative to the directory of the main "t.cmd"
echo file) into the compilation path. Any additional libraries that are
echo common to all problems shall be stored there.
echo . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
echo RUN
echo Usage: t run ^<srcfile^> [^<arguments^>...]
echo Runs the specified source or executable file. It assumes that the
echo source file is already compiled using make subcommand and uses the
echo corresponding command to run it. For example, "t run solution.dpr"
echo will actually run "solution.exe", while "t run solution.java" will
echo actually run "java solution". Extension may be omitted just like in
echo make subcommand. 
echo . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
echo TIME
echo Usage: t time ^<srcfile^> [^<arguments^>...]
echo Works like run subcommand, but execution is wrapped into 
echo "..\bin\run.exe -q -e" call (relative to the directory of the main 
echo "t.cmd" file) if the corresponding wrapper file exists, otherwise 
echo run is performed directly.
echo . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
echo FEEDBACK
echo Please report all bugs and suggestions for this tool to Roman Elizarov
echo using email elizarov@acm.org
echo =========================================================================
exit /b

rem --------------------------------- BUILD ---------------------------------

:build
if not exist tests (
  rem Recurse through subdirs
  echo Scanning %CD%
  call :rec_sub %*
  exit /b
)

for %%i in (%CD%) do set problem=%%~ni
echo Building problem %problem% in %CD%
del build.log 2> nul

set srcfile=%2
set testnos=%3
:build_testnos
shift
if "%3" == "" goto build_done_testnos
set testnos=%testnos% %3
goto build_testnos
:build_done_testnos

rem Always run "doall" if it exists
call :expand tests/doall
if exist %result% (
  pushd tests
  rem Make sure all tests are clean before rerunning "doall"
  for /l %%i in (0,1,9) do for /l %%j in (0,1,9) do del %%i%%j 2> nul
  call %tcmd% make doall
  call %tcmd% run doall
  popd
)

if "%testnos%" == "" (
  rem If generating all tests, then also make checker
  call %tcmd% make check
  rem And actually all tests themselves
  for /l %%i in (0,1,9) do for /l %%j in (0,1,9) do call :build_generate_sub %%i%%j
) else (
  for %%i in (%testnos%) do call :build_generate_sub %%i
)

rem figure out what solution to use
call :resolve_solution_sub

if not exist %srcfile% (
  echo NO SOLUTION FOUND FOR PROBLEM %problem%.
  exit /b
)

:build_solution_found
echo Building answer files with %srcfile%
call %tcmd% make %srcfile%
if errorlevel 1 (
  echo Failed to make %srcfile%. Will not build answer files.
  exit /b
)

set success=true
if "%testnos%" == "" (
  for /l %%i in (0,1,9) do for /l %%j in (0,1,9) do (
    call :build_ans_sub %%i%%j
  )
) else (
  for %%i in (%testnos%) do (
    call :build_ans_sub %%i
  ) 
)

rem del %problem%.in 2> nul
rem del %problem%.out 2> nul

if "%success%" == "true" (
  echo BUILD SUCCESSFUL FOR PROBLEM %problem%.
  exit /b 0
) else (
  echo BUILD FAILED FOR PROBLEM %problem%. See build.log.
  exit /b 1
)

:build_generate_sub
if not exist tests\do%1.dpr goto :testjava
echo Generating problem %problem% test %1.
del tests\%1 2> nul
del tests\%1.a 2> nul
call %tcmd% make tests\do%1.dpr
if errorlevel 1 (
  echo Failed to genereate problem %problem% test %1.
) else (
  call %tcmd% run tests\do%1.exe > tests\%1
  del tests\do%1.exe 2> nul
)
exit /b
:testjava
if not exist tests\do%1.java exit /b
echo Generating problem %problem% test %1.
del tests\%1 2> nul
del tests\%1.a 2> nul
pushd tests
call %tcmd% make do%1.java
popd
if errorlevel 1 (
  echo Failed to genereate problem %problem% test %1.
) else (
  pushd tests
  call %tcmd% run do%1.java > %1
  del do%1.class 2> nul
  popd
)
exit /b

:build_ans_sub
if not exist tests\%1 exit /b
echo Running %srcfile% on problem %problem% test %1.
del %problem%.out 2> nul
copy tests\%1 %problem%.in > nul
call %tcmd% time %srcfile%
if errorlevel 1 (
  call :testlogerror build %1
  set success=false
) else (
  if exist %problem%.out (
    copy %problem%.out tests\%1.a > nul
    call %tcmd% run check %problem%.in %problem%.out tests\%1.a
    call :testlog build %1 Done
  ) else (
    call :testlog build %1 Failed to create output
    set success=false
  )
)
exit /b

rem --------------------------------- CHECK ---------------------------------

:check
if not exist tests (
  rem Recurse through subdirs
  echo Scanning %CD%
  call :rec_sub %*
  exit /b
)

for %%i in (%CD%) do set problem=%%~ni
echo Checking problem %problem% in %CD%

del check.log 2> nul
del run.dat 2> nul

set srcfile=%2
set testnos=%3
:check_testnos
shift
if "%3" == "" goto check_done_testnos
set testnos=%testnos% %3
goto check_testnos
:check_done_testnos

call %tcmd% make check
if errorlevel 1 (
  echo CHECK FAILED FOR PROBLEM %problem%. Cannot make check.
  exit /b 1
)

rem figure out what solution to use
call :resolve_solution_sub

call %tcmd% make %srcfile%
if errorlevel 1 (
  echo CHECK FAILED FOR PROBLEM %problem%. Cannot make %srcfile%.
  exit /b 1
)

set success=true
if "%testnos%" == "" (
  for /l %%i in (0,1,9) do for /l %%j in (0,1,9) do call :check_sub %%i%%j
) else (
  for %%i in (%testnos%) do call :check_sub %%i
)
del %problem%.in 2> nul
del %problem%.out 2> nul

if exist run.dat (
  echo WORST TIME IS:
  type run.dat
)

if "%success%" == "true" (
  echo CHECK SUCCESSFUL FOR PROBLEM %problem%.
  exit /b 0
) else (
  echo CHECK FAILED FOR PROBLEM %problem%. See check.log.
  exit /b 1
)

:check_sub
if not exist tests\%1 exit /b
echo Running %srcfile% on problem %problem% test %1.
del %problem%.out 2> nul
copy tests\%1 %problem%.in > nul
call %tcmd% time %srcfile%
if errorlevel 1 (
  call :testlogerror check %1
  set success=false
) else (
  if exist tests\%1.a (
    call %tcmd% run check %problem%.in %problem%.out tests\%1.a
    if errorlevel 1 (
      call :testlog check %1 Check has not accepted solution
      set success=false
    ) else (
      call :testlog check %1 Done
    )
  ) else (
    call :testlog check %1 Answer file is not found
    set success=false
  )
)
exit /b

rem --------------------------------- XML ---------------------------------

:xml
if not exist tests (
  rem Recurse through subdirs
  echo Scanning %CD%
  call :rec_sub %*
  exit /b
)

for %%i in (%CD%) do set problem=%%~ni
echo XML for problem %problem% in %CD%

set prefix=%2
set timelimit=%3
set memorylimit=%4

if "%prefix%" == """" set prefix=

del problem.xml 2> nul

if "%timelimit%" == "" set timelimit=2s
if "%memorylimit%" == "" set memorylimit=67108864

if not exist check.exe (
  echo XML FAILED FOR PROBLEM %problem% -- must build first, check.exe is missing.
  exit /b 1
)

set lasttest=
set testcount=0
for /l %%i in (0,1,9) do for /l %%j in (0,1,9) do (
  if exist tests\%%i%%j (
    if not exist tests\%%i%%j.a (
      echo XML FAILED FOR PROBLEM %problem% -- must build first, answer is missing.
      exit /b 1
    )
    set lasttest=%%i%%j
    call :xml_inc_testcount
  ) else if exist tests\do%%i%%j.dpr (
    echo XML FAILED FOR PROBLEM %problem% -- must build first, test is missing.
    exit /b 1
  )
)

if "%lasttest:~0,1%" == "0" set lasttest=%lasttest:~1%

if "%lasttest%" NEQ "%testcount%" (
  echo XML FAILED FOR PROBLEM %problem% -- noncontiguous test set.
  exit /b 1
)

call :xml_print > problem.xml
echo XML SUCCESSFUL FOR PROBLEM %problem%.
exit /b

:xml_inc_testcount
set /a testcount=%testcount%+1
exit /b

:xml_print

echo ^<problem
echo     id      = "%prefix%%problem%"
echo     version = "1.0"
echo ^>
echo     ^<judging^>
echo         ^<script type = "%%icpc"^>
echo             ^<testset
echo                 test-count   = "%testcount%"
echo                 input-href   = "tests/##"
echo                 answer-href  = "tests/##.a"
echo                 input-name   = "%problem%.in"
echo                 output-name  = "%problem%.out"
echo                 time-limit   = "%timelimit%"
echo                 memory-limit = "%memorylimit%"
echo             /^>
echo             ^<verifier type = "%%testlib"^>
echo                 ^<binary executable-id = "x86.exe.win32" file = "check.exe" /^>
echo             ^</verifier^>
echo         ^</script^>
echo     ^</judging^>
echo ^</problem^>

exit /b

rem --------------------------------- PCMS ---------------------------------

:pcms
if [%dir%]==[] (
    set dir=%~dp0
)

if not exist tests (
  rem Recurse through subdirs
  echo Scanning %CD%
  call :rec_sub %*
  exit /b
)

for %%i in (%CD%) do set problem=%%~ni
echo PCMS for problem %problem% in %CD%

if not exist check.exe (
  echo PCMS FAILED FOR PROBLEM %problem% -- must build first, check.exe is missing.
  exit /b 1
)

if not exist problem.xml (
  echo PCMS FAILED FOR PROBLEM %problem% -- must build xml first, problem.xml is missing
  exit /b 1
)

set lasttest=
set testcount=0
for /l %%i in (0,1,9) do for /l %%j in (0,1,9) do (
  if exist tests\%%i%%j (
    if not exist tests\%%i%%j.a (
      echo PCMS FAILED FOR PROBLEM %problem% -- must build first, answer is missing.
      exit /b 1
    )
    set lasttest=%%i%%j
    call :xml_inc_testcount
  ) else if exist tests\do%%i%%j.dpr (
    echo PCMS FAILED FOR PROBLEM %problem% -- must build first, test is missing.
    exit /b 1
  )
)

if "%lasttest:~0,1%" == "0" set lasttest=%lasttest:~1%

if "%lasttest%" NEQ "%testcount%" (
  echo XML FAILED FOR PROBLEM %problem% -- noncontiguous test set.
  exit /b 1
)

echo Copying %testcount% tests

if not exist %dir%\__pcms\%problem%\ mkdir %dir%\__pcms\%problem%
if not exist %dir%\__pcms\%problem%\tests\ mkdir %dir%\__pcms\%problem%\tests\
for /l %%i in (0,1,9) do for /l %%j in (0,1,9) do (
  if exist tests\%%i%%j (
    copy tests\%%i%%j %dir%\__pcms\%problem%\tests\ > nul
    copy tests\%%i%%j.a %dir%\__pcms\%problem%\tests\ > nul
  )
)

echo Copying problem.xml
copy problem.xml %dir%\__pcms\%problem%\ > nul

echo Copying checker
copy check.exe %dir%\__pcms\%problem%\ > nul
copy check.dpr %dir%\__pcms\%problem%\ > nul

echo PCMS SUCCESSFUL FOR PROBLEM %problem%.
exit /b

rem --------------------------------- CLEAN ---------------------------------

:clean
if not exist tests (
  rem Recurse through subdirs
  echo Scanning %CD%
  call :rec_sub %*
  exit /b
)

echo Cleaning %CD%

call :expand tests\doall
if exist %result% (
  for /l %%i in (0,1,9) do for /l %%j in (0,1,9) do del tests\%%i%%j 2> nul
)
for /l %%i in (0,1,9) do for /l %%j in (0,1,9) do (
  if exist tests\do%%i%%j.dpr (
    del tests\%%i%%j 2> nul
  )
  del tests\%%i%%j.a 2> nul
)
del tests\*.exe 2> nul
del tests\*.dcu 2> nul
del tests\*.obj 2> nul
del *.exe 2> nul
del *.dcu 2> nul
del *.obj 2> nul
del *.class 2> nul
del *.in 2> nul
del *.out 2> nul
del *.log 2> nul
del run.dat 2> nul
del problem.xml 2> nul
exit /b

rem --------------------------------- MAKE ---------------------------------

:make
set srcfile=%2
call :expand_sub

if /i "%srcfile:~-4%" == ".dpr" (
  call dcc32 -m -cc -U%~dp0..\testlib\ %srcfile% 
  exit /b
)
if /i "%srcfile:~-5%" == ".java" (
  call javac -classpath .;%~dp0..\testlib\ %srcfile%
  exit /b
)
if /i "%srcfile:~-4%" == ".cpp" (
  call cl -I%~dp0..\testlib\ %srcfile%
  exit /b
)
if /i "%srcfile:~-2%" == ".c" (
  call cl -I%~dp0..\testlib\ %srcfile%
  exit /b
)
if /i "%srcfile:~-4%" == ".cmd" (
  exit /b
)
if /i "%srcfile:~-4%" == ".exe" (
  exit /b
)
echo Cannot make %srcfile%. Unsupported type.
exit /b 1

rem --------------------------------- TIME ---------------------------------

:time

set wrapper=%~dp0..\bin\run.exe
if exist %wrapper% (
  set wrapper=%wrapper% -q -e
) else (
  set wrapper=
)
goto run_main

rem --------------------------------- RUN ---------------------------------

:run
set wrapper=

:run_main

set srcfile=%2
call :expand_sub

rem Build actual arguments list
shift
shift
set cmdargs=
:run_cmdargs_loop
if "%1" == "" goto run_cmdargs_done
set cmdargs=%cmdargs% %1
shift
goto run_cmdargs_loop
:run_cmdargs_done

if /i "%srcfile:~-4%" == ".dpr" (
  call %wrapper% %srcfile:~0,-4%.exe %cmdargs%
  exit /b
)
if /i "%srcfile:~-5%" == ".java" (
  if "%wrapper%" == "" (
    call %wrapper% java -Xss64m -cp . -ea %srcfile:~0,-5% %cmdargs%
  ) else (
    call %wrapper% --ignore-first-chance-exceptions java -Xss64m -cp . -ea %srcfile:~0,-5% %cmdargs%
  )     
  exit /b
)
if /i "%srcfile:~-4%" == ".class" (
  if "%wrapper%" == "" (
    call %wrapper% java -Xss64m -cp . -ea %srcfile:~0,-4% %cmdargs%
  ) else (
    call %wrapper% --ignore-first-chance-exceptions java -Xss64m -cp . -ea %srcfile:~0,-5% %cmdargs%
  )     
  exit /b
)
if /i "%srcfile:~-4%" == ".cpp" (
  call %wrapper% %srcfile:~0,-4%.exe %cmdargs%
  exit /b
)
if /i "%srcfile:~-2%" == ".c" (
  call %wrapper% %srcfile:~0,-2%.exe %cmdargs%
  exit /b
)
if /i "%srcfile:~-4%" == ".cmd" (
  call %wrapper% cmd /c %srcfile% %cmdargs%
  exit /b
)
if /i "%srcfile:~-4%" == ".exe" (
  call %wrapper% %srcfile% %cmdargs%
  exit /b
)
echo Cannot run %srcfile%. Unsupported type.
exit /b 1

rem ---------------------------- COMMON SUBROUTINES -----------------------

:rec_sub
rem Recursively repeats the same command in all subdirectories
for /d %%d in (*) do if /i "%%d" neq "tests" if /i "%%d" neq ".svn" if /i "%%d" neq "CVS" (
  pushd %%d
  call %~f0 %*
  popd
)
exit /b

:resolve_solution_sub
rem Resolves specified shortcut for solution into actual file

if exist "%srcfile%" (
  rem exitisting file was specified -- nothing more to do
  exit /b
)
if "%srcfile%" == "" (
  rem Just try problem name for solution name if none was specified
  set srcfile=%problem%
) else (
  rem Append suffix to problem name in attempt to find solution name
  set srcfile=%problem%_%srcfile%
)
rem !!! Now falls to expand_sub in order to find an appropriate extension for solution
:expand_sub
call :expand %srcfile%
set srcfile=%result%
exit /b

:expand
rem Usage "call :expand <file>" returns expaned file name in "result"
rem Expands <file> by checking various extensions in order: .dpr, .java, .cpp, .c, .cmd, .exe
set result=%1
if exist %result% exit /b
for %%i in (dpr java cpp c cmd exe) do if exist %result%.%%i (
  set result=%result%.%%i
  exit /b
)
exit /b

:testlogerror
rem Usage "call :testlogerror <action> <test>"
call :testlog %1 %2 Failed to run with exitcode %ERRORLEVEL%
exit /b

:testlog
rem Usage "call :testlog <action> <test> <message>"
set action=%1
set test=%2
shift
shift
set message=%1
shift
:testlog_message_loop
if "%1" == "" goto testlog_message_done
set message=%message% %1
shift
goto testlog_message_loop
:testlog_message_done

echo %message% on problem %problem% test %test%.
echo %test% %message% >> %action%.log
exit /b

:terminate