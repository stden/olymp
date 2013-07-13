{R+,Q+,O-}
program division;

{$APPTYPE CONSOLE}
const size=110;
type long=array[1..size] of byte;
var ans:array[0..320,0..320]of char;s:string;
    d1,d2,d3,d4:long;i,point,curstr,curdig:integer;
    d:array[1..10]of long;

function len(n:long):integer;
var i:integer;
begin
 i:=size;while (i>1)and(n[i]=0)do dec(i);
 len:=i;
end;

function le(n1,n2:long):boolean;
var i:integer;
begin
 for i:= size downto 1 do
 begin
  if n1[i]<n2[i]then begin le:=true;exit;end;
  if n1[i]>n2[i]then begin le:=false;exit;end;
 end;
 le:=true;
end;

procedure add(var n1,n2,n3:long);
var per,i:integer;
begin
 per:=0;
 for i:= 1 to size do
  begin per:=per+n1[i]+n2[i];n3[i]:= per mod 10;per:=per div 10;end;
end;

procedure sub(var n1,n2,n3:long);
var need,i:integer;
begin
 need:=0;
 for i:= 1 to size do
 begin
  need:=need+n1[i]-n2[i];
  if need<0 then begin n3[i]:= (need+10) mod 10; need:=-1;end
            else begin n3[i]:= need mod 10; need:=0;end
 end;
end;

procedure printnum (var n:long;x,y:integer);
var ok:boolean;i:integer;
begin
 ok:=false;
 for i:= size downto 1 do
  if (n[i]>0)or ok or(i=1) then
   begin ans[x,y]:=chr(n[i]+ord('0'));inc(x);ok:=true; end;
end;

procedure printnumrev (var n:long;x,y:integer;c:char);
var i,max:integer;
begin
 max:=size;while (max>1)and(n[max]=0)do dec(max);
 for i:= 1 to max do
  begin ans[x,y]:=chr(n[i]+ord('0'));ans[x,y+1]:=c;dec(x); end;
  if ans[x,y-1] in ['1'..'9'] then ans[x,y+1]:=c;
end;

procedure outp;
var i,j,maxx,maxy:integer;
label l;
begin
 for i:=1 to 320 do for j:= 1 to 320 do
  if (ans[i-1,j]=' ')and(ans[i,j]='0')and(ans[i+1,j]<>' ')then ans[i,j]:=' ';
 maxy:=320;
 while true do
 begin
  for i:= 1 to 320 do
   if ans[i,maxy]<>' ' then goto l;
  dec(maxy);
 end;
 l:
 for i:=1 to maxy do
 begin
  maxx:=320;while ans[maxx,i]=' ' do dec(maxx);
  for j:= 1 to maxx do write(ans[j,i]);
  writeln;
 end;
end;

begin
 assign(input,'division.in');reset(input);
 assign(output,'division.out');rewrite(output);
 fillchar(ans,sizeof(ans),' ');
 assert(not seekeoln);readln(s);assert((length(s)<=100));
 assert((s[1]<>'0')or (length(s)=1));
 for i:=length(s) downto 1 do
 begin
  assert((s[i]<='9')and(s[i]>='0'));
  d1[length(s)+1-i]:=ord(s[i])-ord('0');
 end;
 assert(not seekeoln);readln(s);assert((length(s)<=100)and(s[1]<>'0'));
 for i:=length(s) downto 1 do
 begin
  assert((s[i]<='9')and(s[i]>='0'));
  d2[length(s)+1-i]:=ord(s[i])-ord('0');
 end;
 assert(seekeof);

 d[1]:=d2;for i:=2 to 10 do add(d[i-1],d2,d[i]);
 printnum(d1,1,1);
 curstr:=1;
 ans[len(d1)+2,1]:='|';ans[len(d1)+2,2]:='+';ans[len(d1)+2,3]:='|';
 printnum(d2,len(d1)+3,1);
 for point:= len(d1) downto 1 do
 begin
  for i:= size downto 2 do d3[i]:=d3[i-1];d3[1]:=d1[point];
  ans[len(d1)+1-point,curstr]:=chr((d1[point])+ord('0'));
  ans[len(d1)+1-point,curstr-1]:='-';
  curdig:=1;while le(d[curdig],d3)do inc(curdig);
  dec(curdig);
  d4[point]:=curdig;
  if curdig>0 then
  begin
   sub(d3,d[curdig],d3);
   printnumrev(d[curdig],len(d1)+1-point,curstr+1,'-');
   printnumrev(d3,len(d1)+1-point,curstr+3,' ');
   inc(curstr,3);
  end;
 end;
 printnum(d4,len(d1)+3,3);
 i:=len(d1)+3;while (ans[i,1] in ['0'..'9'])or(ans[i,3] in ['0'..'9'])do
  begin ans[i,2]:='-';inc(i);end;
 outp;
 close(output);
 close(input);
end.
