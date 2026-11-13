set problem=quadratic

if exist tests\do%1.dpr (
    cd tests
    call dcc32 -cc do%1.dpr > nul
    cd ..
)

if exist tests\do%1.exe (
    cd tests
    do%1 > %1
    cd ..
)

if exist tests\%1 (
    copy tests\%1 %problem%.in > nul
    %problem%_as
    copy %problem%.out tests\%1.a > nul
    check %problem%.in %problem%.out tests\%1.a
)