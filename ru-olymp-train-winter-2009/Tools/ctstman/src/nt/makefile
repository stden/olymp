.extensions:
.extensions: .exe .obj .cpp

goal: colorchk.exe unix2dos.exe

.cpp.obj:
	wpp386	-bt=nt $^&

.obj.exe:
	wlink	f $^& sys nt
