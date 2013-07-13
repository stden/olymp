{$M 16000000}
{$MODE DELPHI}
{$GOTO ON}
const MAXL = 1000;
type long = array[1..MAXL] of integer;
procedure add(var a,b:long);
var carry,i:integer;
begin
	carry:=0;
	for i:=1 to MAXL do begin
		carry := carry+a[i]+b[i];
		a[i] := carry mod 10;
		carry := carry div 10;
	end;	

	if carry<>0 then begin
		writeln(erroutput,'FAIL');
		halt(1);
	end;
end;

var n,i:integer;
a,b,c:long;
wr:boolean;
begin
	assign(input,'pines.in');
	reset(input);
	assign(output,'pines.out');
	rewrite(output);
	read(n);
	if (n<2) then begin
		writeln(0);
	end
	else if (n<7) then begin
		writeln(0);
	end
	else begin
		fillchar(a,sizeof(a),0);
		fillchar(b,sizeof(b),0);
		a[1]:=1;
		b[1]:=1;
		for i:=1 to n-6 do begin
			c := a;
			add(a,b);
			b := c;
		end;
		wr:=false;
		for i:=MAXL downto 1 do begin
			if (a[i]<>0) then wr:=true;
			if (wr) then write(a[i]);
		end;
	end;
	close(input);
	close(output);
end.
