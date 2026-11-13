{$R+,Q-,S+,O-}
program tts_VT;
{$APPTYPE CONSOLE}

uses SysUtils;


type pedge=^tedge;
     tedge=record
      v:integer;
      rig:integer;
      next:pedge;
     end;

const max=3000;
var names:array[1..max]of string;
graph:array[1..max,1..max] of pedge;
head:array[1..max] of pedge;
was:array[1..max] of boolean;
maxvert:integer;mask,err,i,j:integer;
lex,so,de:string;

procedure getlex(var s:string);
var c:char;
begin
 s:='';
 while true do
 begin
  read(c);if (ord(c)=9)or(ord(c)=13) then break;
  s:=s+c;
  if eof then break;
 end;
 assert(s<>'');
end;

procedure add (v1,v2,m:integer;c:char);
var temp,temp2:pedge;
begin
 if graph[v1,v2]=nil then
 begin
  temp2:=head[v1];
  new(temp);
  temp^.v:=v2;
  temp^.rig:=0;
  temp^.next:=temp2;
  head[v1]:=temp;
  graph[v1,v2]:=temp;
 end;
 if c='=' then graph[v1,v2]^.rig:=m;
 if c='+' then graph[v1,v2]^.rig:=m or graph[v1,v2]^.rig;
 if c='-' then graph[v1,v2]^.rig:=not m and graph[v1,v2]^.rig;
end;

function num(s:string):integer;
var i:integer;
begin
 i:=1;
 while i<=maxvert do begin if names[i]=s then break;inc(i);end;
 if i=maxvert+1 then begin inc(maxvert);names[i]:=s; add(1,i,-1,'=');add(i,2,-1,'=');end;
 num:=i;
end;

procedure search(vert,posit:integer);
var pp:pedge;
begin
 was[vert]:=true;
 pp:=head[vert];
 while pp <> nil do
 begin
  if (not was[pp^.v])and odd(pp^.rig shr posit) then search(pp^.v,posit);
  pp:=pp^.next;
 end;
end;

procedure check(v1,v2:integer);
var r,er,i:integer;
begin
 r:=0;
 er:=0;
 for i:= 0 to 31 do
 begin
  fillchar(was,sizeof(was),false);
  search(v1,i);
  if was[v2] then r:=r or (1 shl i);
 end;
 for i:= 0 to 7 do
 begin
  if odd(i) then
  begin
   if odd(r shr (4*i))   then er:=er and 14;
   if odd(r shr (4*i+1)) then er:=er and 13;
   if odd(r shr (4*i+2)) then er:=er and 11;
   if odd(r shr (4*i+3)) then er:=er and 7;
  end else
  begin
   if odd(r shr (4*i))   then er:=er or 1;
   if odd(r shr (4*i+1)) then er:=er or 2;
   if odd(r shr (4*i+2)) then er:=er or 4;
   if odd(r shr (4*i+3)) then er:=er or 8;
  end;
 end;
 write(names[v1],' has ');
 if odd(er shr 3) then write('A');
 if odd(er shr 2) then write('R');
 if odd(er shr 1) then write('W');
 if odd(er shr 0) then write('X');
 if er = 0 then write('no');
 writeln(' rights on ',names[v2],'.');
end;

begin
 assign(input,'tts.in');reset(input);
 assign(output,'tts.out');rewrite(output);
 for i:= 1 to max do for j:= 1 to max do graph[i,j]:=nil;
 for i:= 1 to max do head[i]:=nil;
 maxvert:=2; names[1]:='initial';names[2]:='final'; add(1,2,-1,'=');
 while not seekeof do
 begin
  getlex(lex);
  getlex(lex);
  if lex[1]='R' then
  begin
   getlex(lex);
   getlex(so);
   getlex(de);
   check(num(so),num(de));
  end else
  begin
   getlex(so);
   getlex(so);
   getlex(de);if de='-' then de:='-1';
   if de[1]='-' then
   begin
    de:=copy(de,2,length(de)-1);
    val(de,mask,err);
    assert(err=0);
    mask:=mask*(-1);
   end else
   begin
    val(de,mask,err);
    assert(err=0);
   end;
   while not seekeoln do
   begin
    getlex(de);
    if lex[2]='G' then assert((num(so)<>1)and(num(de)<>2))
                  else assert((num(de)<>1)and(num(so)<>2));
    if lex[2]='G' then add(num(so),num(de),mask,lex[1])
                  else add(num(de),num(so),mask,lex[1]);
   end;
  end;
  if seekeof then break;
 end;
 close(output);
 close(input);
end.
