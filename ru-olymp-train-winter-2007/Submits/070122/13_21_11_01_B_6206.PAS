{$MODE DELPHI}
const
	maxa = 20;
type
  state = array[0..2*maxa+1]of integer;
var
	a,c,r,w,first,next :array[0..200] of integer;
  d:array[0..200] of state;
  tmp1,tmp2:state;
function min(a,b:integer):integer;
begin
	if (a<b) then result := a
	else result := b;
end;
procedure dfs(v:integer);
var 	p,i,j:integer;
begin
  p:= first[v];
  while (p<>0) do begin
  	dfs(p);
  	p := next[p];
  end;
  tmp1 := d[r[v]];
  for i:=c[v]+1 to maxa do begin
    for j:=1 to maxa do begin
			tmp1[j+a[v]] :=  min(d[r[v]][j+a[v]],d[r[v]][j]+d[v][i]);
    end;
  end;
  tmp2 := d[r[v]];
  for i:=0 to c[v] do begin
    for j:=0 to maxa do begin
      tmp2[j+a[v]] :=  min(tmp2[j+a[v]],d[r[v]][j]+d[v][i]+w[v]);
    end;
  end;
  for i:=1 to maxa do
    d[r[v]][i] := min(d[r[v]][i],min(tmp1[i],tmp2[i]));
end;
var
	i,ans,n:integer;
begin
	assign(input,'system.in');
	reset(input);
	assign(output,'system.out');
	rewrite(output);
	read(n);
	fillchar(first,sizeof(first),0);
	for i:=1 to n do begin
		read(r[i],c[i],a[i],w[i]);
		next[i] := first[r[i]];
		first[r[i]] := i;
	end;
	fillchar(d,sizeof(d),62);
  for i:=1 to n do begin
    d[i][0] := 0;
  end;
	dfs(1);
	ans := 1000000000;
	for i:=c[1]+1 to maxa do begin
		ans := min(ans,d[1][i]);
	end;
	for i:=1 to c[1] do begin
		if (i+a[1]>c[1]) then ans := min(ans,d[1][i]+w[1]);
	end;
  writeln(ans);
	close(input);
	close(output);
end.
