.extensions:
.extensions: .exe .obj .cpp .pas

goal: arcname.exe rentst.exe

.pas.exe:
	tpc	$^&

.cpp.obj:
	wpp	-bt=dos $^&.cpp

.obj.exe:
	wlink	sys dos f $^& op map op stack=4096
