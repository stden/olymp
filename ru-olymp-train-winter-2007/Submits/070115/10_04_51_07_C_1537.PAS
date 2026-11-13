//Written by Assaron
//assaron@mail.ru
const
a=1;b=2;c=3;
u=0;
var
m:array[1..2,0..3]of boolean;
t:integer;
i,j:integer;
l:integer;
//k:integer;
ch:char;
begin
  assign(input,'bit.in');reset(input);
  assign(output,'bit.out');rewrite(output);
  readln(t);
  for i:=1 to t do begin
    readln(l);
    m[1,u]:=true;
    m[1,a]:=false;
    m[1,b]:=false;
    m[1,c]:=false;
    for j:=2 to l do begin
      read(ch);
      m[2,u]:=m[1,ord(ch)-ord('a')+1];
//-------a-------
      m[2,a]:=(ch<>'a')and( m[1,6-a-(ord(ch)-ord('a')+1)] or m[1,u]);
//-------b-------
      m[2,b]:=(ch<>'b')and( m[1,6-b-(ord(ch)-ord('a')+1)] or m[1,u]);
//-------c-------
      m[2,c]:=(ch<>'c')and( m[1,6-c-(ord(ch)-ord('a')+1)] or m[1,u]);
      m[1]:=m[2];
    end;
    readln(ch);
    if m[2,ord(ch)-ord('a')+1] then writeln('YES') else writeln('NO');
    {
    for i:=0 to 3 do begin
      for k:=1 to l do begin
        write(m[k,i],' ');
      end;
      writeln;
    end;
    }
  end;
  close(input);
  close(output);
end.