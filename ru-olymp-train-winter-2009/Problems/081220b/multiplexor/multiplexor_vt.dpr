{$R+,Q-,O+}
{$APPTYPE CONSOLE}
{MODE DELPHI}
program multiplexor_VT;
uses SysUtils;
function isnum (const s:string):boolean; 
var i:integer;
begin 
  Result:=true; 
  for i:=1 to length (s) do if not (s[i] in ['0'..'9']) then begin
    Result:=false;
    exit;
  end;
end;
type rul=record
	fs,fe:cardinal;
	too:string;
	ids,ide:string;
	pas:string;
	end;
var r:array[1..64,1..64]of rul;
rsize:array[1..64]of integer;
ssize,i,j:integer;
t1,t2:cardinal;
port:array[1..64]of cardinal;
c:char;
s:string;
req:rul;
label check,next;

begin
	assign(input,'multiplexor.in'); reset (input);
	assign(output,'multiplexor.out'); rewrite (output);
	ssize:=0;
	read(c);
	while c='A' do
	begin
		inc(ssize);
		rsize[ssize]:=0;
		readln(port[ssize]);
		read(c);
		while c='F' do
		begin
			inc(rsize[ssize]);
			if seekeoln then;
			t1:=0;t2:=0;
			read(c);
			while c in ['0'..'9','.'] do
			begin
				if c ='.' then begin t1:=t1 shl 8+t2;t2:=0;end
				else t2:=t2*10+ord(c)-ord('0');
				read(c);
			end;
			t1:=t1 shl 8 +t2;t2:=0;
			if c='/' then 
			begin
				read(c);
				while c in ['0'..'9'] do begin t2:=t2*10+ord(c)-ord('0');read(c);end;
			end else t2:=32;

			t2:=32-t2;
			if t2<>32 then r[ssize,rsize[ssize]].fs:= (t1 shr t2)shl t2
				  else r[ssize,rsize[ssize]].fs:= 0;
			if t2<>32 then r[ssize,rsize[ssize]].fe:= (((t1 shr t2)+1)shl t2)-1
				  else r[ssize,rsize[ssize]].fe:=r[ssize,rsize[ssize]].fs-1;
			if seekeoln then;read(c);assert(c='T');if seekeoln then;
			s:='';
			read(c);
			while c in ['0'..'9','.'] do begin s:=s+c; read(c);end;
			if seekeoln then;
			r[ssize,rsize[ssize]].too:=s;
			if seekeoln then begin readln;read(c);continue;end;
			read(c);
			if c = 'I' then 
			begin
				if seekeoln then;
				s:='';
				read(c);
				while c in ['0'..'9', 'A'..'Z', 'a'..'z'] do begin s:=s+c;read(c);end;
				r[ssize,rsize[ssize]].ids:=s;
				if c='-' then 
				begin
					s:='';
					read(c);
					while c in ['0'..'9'] do begin s:=s+c;read(c);end;
				end;
				r[ssize,rsize[ssize]].ide:=s;
				if seekeoln then begin readln;read(c);continue;end;
				read(c);
			end;
			assert(c='P');
			if seekeoln then;
			readln(r[ssize,rsize[ssize]].pas);
			read(c);
		end;
	end;
	assert(c='-');
	readln;
	while not seekeof do
	begin
		read(c);assert(c='F');
		if seekeoln then;
		t1:=0;t2:=0;
		read(c);
		while c in ['0'..'9','.'] do
		begin
			if c ='.' then begin t1:=t1 shl 8+t2;t2:=0;end
			else t2:=t2*10+ord(c)-ord('0');
			read(c);
		end;
		t1:=t1 shl 8 +t2;
		req.fs:= t1;
		if seekeoln then;read(c);assert(c='T');if seekeoln then;
		read(req.fe);
		if seekeoln then begin readln;req.pas:='incorrect password';req.ids:='';goto check;end;
		read(c);
		if c = 'I' then 
		begin
			if seekeoln then;
			s:='';
			read(c);
			while c in ['0'..'9', 'A'..'Z', 'a'..'z'] do begin s:=s+c;read(c);end;
			req.ids:=s;
			if seekeoln then begin readln;req.pas:='incorrect password';goto check;continue;end;
			read(c);
		end else req.ids:='';
		assert(c='P');
		if seekeoln then;
		readln(req.pas);
		check:
	for i:= 1 to ssize do
		if req.fe=port[i] then
			for j:= 1 to rsize[i] do
			begin
				if (req.fs>r[i][j].fe)or(req.fs<r[i][j].fs)then continue;
				if (r[i][j].pas<>'') and (r[i][j].pas<>req.pas)then continue;
				if (r[i][j].ids<>'') and 
				  ((length(r[i][j].ids)<>length(req.ids))or
				   ((r[i][j].ids>req.ids)or(r[i][j].ide<req.ids))
				   or ((r[i][j].ids<>r[i][j].ide) and not isnum (req.ids))
				  ) then continue;
				writeln(r[i][j].too);
				goto next;
			end;
	writeln('/dev/null');
	next:
	end;
	close(output);
	close(input);

end.
