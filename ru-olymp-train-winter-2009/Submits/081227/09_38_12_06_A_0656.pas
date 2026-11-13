program fignya;

const
 n=7;
 eps:array[1..n]of string=('input','randseed','randomize','random','.in','read','readln');

var
 inp,oup:text;
 i:longint;
 s:string;
 sch:array[1..10]of longint;

begin
 assign(inp,'help.in');
 assign(oup,'help.out');
 reset(inp);
 rewrite(oup);
 readln(inp,s);
 fillchar(sch,sizeof(sch),0);
 while not eof(inp) do
  begin
   for i:=1 to n do
    begin
     if pos(eps[i],s)<>0 then
      begin
       inc(sch[i]);
       delete(s,pos(eps[i],s),length(s[i]));
       continue;
      end;
     readln(inp,s);
    end;
  end;
 if (sch[1]=0)or(sch[5]=0)or(sch[6]+sch[7]=0)or(sch[2]+sch[3]+sch[4]<>0) then
  begin
   writeln(oup,'YES');
  end
 else writeln(oup,'NO');
 close(inp);
 close(oup);

end.

