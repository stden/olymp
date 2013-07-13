{$MODE DELPHI}
type integer = longint;
const
  MAXN = 10000;
  MAXM = 300000;
var
  next,e,b:array[1..MAXM] of integer;
  rr,a,r,first:array[1..MAXN] of integer;
  u:array[1..MAXN] of boolean;
	n:integer;

function  dfs(v:integer;in1:boolean):boolean;
var
	p:integer;
begin
	result := false;
	if (v<=0) then exit;
	if (in1) then if (u[v]) then exit;
	if (in1) then u[v] := true;
	if (in1) then begin
		p := first[v];
		while (p<>0) do begin
			if (dfs(e[p],false)) then begin
				r[e[p]] := v;
				result := true;
				exit;
			end;
			p:=next[p];
    end;
	end
	else begin
		if (r[v]=0) then begin
			result := true;
		end
		else begin
			if (dfs(r[v],true)) then begin
				r[v] := -1;
				result := true;
				exit;
			end;
		end;
	end;
end;
procedure no;
begin
	writeln('NO');
	close(input);
	close(output);
	halt;
end;
var
	p,i,j,k,pow,tmp:integer;
begin
	assign(input,'omax.in');
	reset(input);
	assign(output,'omax.out');
	rewrite(output);
	read(n);
	if (n>1000) then no;
	p:=0;
	fillchar(first,sizeof(first),0);
	for i:=1 to n do begin
		read(k);
		for j:=1 to k do begin
			inc(p);
			next[p] := first[i];
			first[i] := p;
			b[p] := i;
			read(e[p]);
		end;
	end;
	pow := 0;
	fillchar(r,sizeof(r),0);
	for i:=1 to n do begin
		fillchar(u,sizeof(u),0);
    if (dfs(i,true)) then inc(pow);
	end;
	for i:=1 to n do begin
		rr[i] := r[i];
	end;
	if (pow<n) then begin
		no;
	end;
	for i:=1 to p do begin
		if (rr[e[i]] = b[i]) then begin
			tmp := e[i];
			e[i] := -1;
			pow := 0;
			fillchar(r,sizeof(r),0);
			for i:=1 to n do begin
				fillchar(u,sizeof(u),0);
		    if (dfs(i,true)) then inc(pow);
			end;
			if (pow=n) then no;
			e[i] := tmp;
		end;
	end;
  for i:=1 to n do begin
		a[rr[i]] := i;
	end;
//	for i:=1 to p
	writeln('YES');
	for i:=1 to n do begin
		write(a[i],' ');
	end;
	close(input);
	close(output);
end.
