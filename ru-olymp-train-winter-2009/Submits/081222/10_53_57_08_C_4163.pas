{$MODE DELPHI}
uses SysUtils;

type
 TLong=array[0..1000] of integer;

var
 n,m:TLong;

function ReadLong:TLong;
var
 c:Tlong;
 s:string;
 i:integer;
begin
 fillchar(c, sizeof(c), 0);
 readln(s);
 s:=trim(s);
 c[0]:=length(s);
 for i:=1 to c[0] do
  c[i]:=strtoint(s[c[0]-i+1]);
 result:=c;
end;

procedure WriteLong(const a:tlong);
var
 i:integer;
begin
 for i:=a[0] downto 1 do write(a[i]);
end;

function MulLong(const A,B:TLong):TLong;
var
 C:TLong;
 i,j:integer;
begin
 fillchar(c, sizeof(c), 0);
 for i:=1 to a[0] do
  for j:=1 to b[0] do begin
   inc(c[i+j-1], a[i]*b[j]);
   inc(c[i+j], c[i+j-1] div 10);
   c[i+j-1]:=c[i+j-1] mod 10;
  end;

 c[0]:=a[0]+b[0];
 if c[c[0]]=0 then dec(c[0]);
 result:=C;
end;

function Plus1(const A:TLong):TLong;
var
 C:Tlong;
 i:integer;
begin
 c:=a;
 inc(c[1]);
 for i:=1 to c[0] do begin
  inc(c[i+1], c[i] div 10);
  c[i]:=c[i] mod 10;
 end;
 if c[c[0]+1]<>0 then inc(c[0]);
 result:=c;
end;

function div3(const a:TLong):TLong;
var
 C:TLong;
 i,o:integer;
begin
 fillchar(c, sizeof(c),0);
 o:=0;
 for i:=a[0] downto 1 do begin
  o:=o*10+a[i];
  c[i]:=o div 3;
  o:=o mod 3;
 end;
 c[0]:=a[0];
 while (c[c[0]]=0) and (c[0]>0) do dec(c[0]);
 if c[0]=0 then c[0]:=1;
 if o>0 then c:=Plus1(c);
 result:=c;
end;


begin
 assign(input, 'room.in'); reset(input);
 assign(output, 'room.out'); rewrite(output);
 n:=readlong;
 m:=Plus1(n);
 m:=MulLong(n,m);
 m:=Div3(m);
 writelong(m);

end.