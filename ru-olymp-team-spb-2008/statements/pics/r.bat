for %%a in (*.mp) do (
    call mp %%a
)
pushd ..
call r.bat
popd