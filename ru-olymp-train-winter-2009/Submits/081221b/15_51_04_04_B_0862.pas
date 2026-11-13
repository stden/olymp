{$H+}
program analiz;

var s:string;
    p,i,n:longint;
    rnds,maxj,maxp,cj,cp,rj,rp:longint;

function strtoint(s0:string):longint;
var i0,x:longint;
begin
  x:=0;
  while not (s0[1] in ['0'..'9']) do delete(s0,1,1);
  while not (s0[length(s0)] in ['0'..'9']) do delete(s0,length(s0),1);
  for i0:=1 to length(s0) do
   x:=x*10+ord(s0[i0])-ord('0');
  strtoint:=x;
end;


label lb1;

begin
 assign(input,'stress.in');
 reset(input);
 assign(output,'stress.out');
 rewrite(output);

  maxj:=-1;
  maxp:=-1;
  while not eof do
  begin

   readln(s);

  while (pos('randseed =',s)=0)and(not eof) do readln(s);
  if eof then
              goto lb1;
   while not (s[1] in ['0'..'9']) do delete(s,1,1);
     rnds:=strtoint(s);


  while pos('Work time:',s)=0 do readln(s);
     while not (s[1] in ['0'..'9']) do delete(s,1,1);
     while not (s[length(s)] = ',') do delete(s,length(s),1);
     cj:=strtoint(s);

  while pos('Work time:',s)=0 do readln(s);
     while not (s[1] in ['0'..'9']) do delete(s,1,1);
     while not (s[length(s)] = ',') do delete(s,length(s),1);
     cp:=strtoint(s);

  if cj>maxj then begin maxj:=cj; rj:=rnds; end;
  if cp>maxp then begin maxp:=cp; rp:=rnds; end;

  writeln('At randseed = ',rnds);
  writeln('First: ',cj,' ms');
  writeln('Second: ',cp,' ms');

  end;
 lb1:
 writeln('Maximal work time for first: ',maxj,' at randseed = ',rj);
 writeln('Maximal work time for second: ',maxp,' at randseed = ',rp);

 close(input);
 close(output);
end.