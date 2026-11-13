{$H+}
type tpath=array[1..4001]of word;
var m,n,p,i,x,j,k:longint;
    gs:string;
    g:array[0..4000,0..4000]of byte;
    ans:array[1..4001]of tpath;
    curp:tpath;
    c:char;

procedure move(k,j:longint);
var i:longint;
begin
  for i:=k downto j do
    curp[i+1]:=curp[i];
end;

begin
  assign(input,'tourism.in');
  reset(input);
  assign(output,'tourism.out');
  rewrite(output);
  readln(n);
  p:=n*(n-1) div 2;
  p:=p div 6+byte(p mod 6<>0);
  gs:='';
  for i:=1 to p do
  begin
    read(c);
    x:=0;
    if c in ['0'..'9'] then
      x:=byte(c)-byte('0');
    if c in ['A'..'Z'] then
      x:=byte(c)-byte('A')+10;
    if c in ['a'..'z'] then
      x:=byte(c)-byte('a')+36;
    if c = '!' then
      x:=62;
    if c = '?' then
      x:=63;
    for j:=1 to 6 do
    begin
      gs:=gs+char(x mod 2+byte('0'));
      x:=x div 2;
    end;
  end;
  k:=0;
  for i:=0 to n-1 do
    for j:=i+1 to n-1 do
    begin
      k:=k+1;
      g[i,j]:=byte(gs[k])-byte('0');
      g[j,i]:=1-g[i,j];
    end;
  curp[1]:=0;
  ans[1]:=curp;
  for i:=1 to n-1 do
  begin
    if g[i,curp[1]]=1 then
    begin
      move(i,1);
      curp[1]:=i;
    end
    else
    if g[curp[i],i]=1 then
      curp[i+1]:=i
    else
      for j:=1 to i-1 do
        if (g[curp[j],i]=1)and(g[i,curp[j+1]]=1) then
        begin
          move(i,j+1);
          curp[j+1]:=i;
          break;
        end;
    ans[i+1]:=curp;
  end;
  read(m);
  for i:=1 to m do
  begin
    read(k);
    for j:=1 to k do
      write(ans[k,j],' ');
    writeln;
  end;
  close(output);
  close(input);
end.
