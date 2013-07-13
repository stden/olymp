{$MODE DELPHI}
type integer = longint;
var
	c:array[1..30,1..30] of boolean;
	len :array[1..30]  of integer;
	n:integer;

procedure bfs(vv:integer);
var queue:array[1..100] of integer;
		v:array[1..100] of boolean;
		head,tail,t,i:integer;
begin
	head:=1;
	tail:=1;
	queue[1]:=vv;
	fillchar(v,sizeof(v),0);
//v[1] := true;
	while (tail+1>head) do begin
		vv:= queue[head];
		inc(head);
		for i:=1 to n do begin
			if (c[vv][i] and (not v[i])) then begin
				v[i] := true;
				inc(tail);
				queue[tail]:=vv;
				len[i]:=len[vv]+1;
			end;
		end;
	end;
end;
var can:array[0..1,1..30] of integer;
		cur,p:integer;
procedure update(ll:integer);
var next,i,j:integer;
begin	
	next:=1-cur;	
	fillchar(can[next],sizeof(can[next]),0);
	for i:=1 to 30 do begin
		for j:=1 to 30 do begin
			if ((i=j) or (len[j]<>ll)) then continue;
			can[next][j] := (can[next][j]+can[cur][i]) mod p;
		end;
	end;
	cur := next;
end;

var i,a,b,t,m,s:integer;
	sum:integer;
begin
	assign(input,'restore.in');
	reset(input);
	assign(output,'restore.out');
	rewrite(output);
	read(n,m,p);
	fillchar(c,sizeof(c),0);
	for i:=1 to m do begin
		read(a,b);
		c[a][b] := true;
		c[b][a] := true;
	end;
 	read(s);
 	fillchar(len,sizeof(len),127);
 	len[s] := 0;
 	bfs(s);
 	read(t);
 	read(a,b);
 	fillchar(can[0],sizeof(can[0]),0);
 	for i:=1 to n do begin
 		if (len[i]=a) then begin
			can[0][i] := 1;
 		end;
 	end;
 	cur:=0;
 	for i:=1 to b-1 do begin
		update(a);
 	end;
 	for i:=1 to t-1 do begin
	 	read(a,b);
	 	for i:=1 to b do begin
			update(a);
	 	end;
 	end;
 	sum:=0;
 	for i:=1 to n do begin
		sum := (sum + can[0][i]) mod p;
 	end;
 	writeln(sum);
  close(input);
  close(output);
end.
