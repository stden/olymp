.extensions:
.extensions: .exe .obj .cpp .pas

goal: colorchk.exe unix2dos.exe

.pas.exe:
	tpc	$^&

.cpp.obj:
	wpp	-bt=dos $^&.cpp

.obj.exe:
	wlink	sys dos f $^& op map op stack=4096
