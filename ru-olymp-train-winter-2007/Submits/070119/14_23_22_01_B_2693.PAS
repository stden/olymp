{$MODE DELPHI}
{$GOTO ON}
label fail;
var
	w,u:array[1..100000] of boolean;
	e,b:array[1..100000] of integer;
	n,m:integer;
	count :int64;
function dfs(v,prev:integer):boolean;
var i:integer;
begin
	result:=true;
	if w[v] then exit;
	w[v] := true;
	for i:=1 to m do begin
		if (b[i]=v)and u[i] then begin
			if (e[i]<>prev) then begin
				if (dfs(e[i],v))then exit;
			end;
		end;
		if (e[i]=v)and u[i] then begin
			if (b[i]<>prev) then begin
				if (dfs(b[i],v))then exit;
			end;
		end;
	end;
	result := false;
end;
procedure test;
var i:integer;
ok:boolean;
begin
	fillchar(w,sizeof(w),0);
	if (not dfs(1,-1)) then begin
		ok:=true;
	  for i:=1 to n do if (not w[i]) then begin
	  	ok:=false;
	  	break;
	  end;
		if (ok) then begin
                        inc(count);
                end;
	end;
end;
procedure rec(step,k:integer);
begin
	if (step = n+1) then begin
		test;
		exit;
	end;
if (k<=n-1) then begin
		u[step] := true;
		rec(step+1,k+1);
end;
if (n-1-k<=m-step) then begin	u[step] := false;
	rec(step+1,k);
end;
end;
var p,i:integer;
begin
	assign(input,'optimum.in');
	reset(input);
	assign(output,'optimum.out');
	rewrite(output);
	read(n,m,p);
	for i:=1 to m do begin
		read(b[i],e[i]);
	end;
	fillchar(u,sizeof(u),0);
	rec(1,0);

	writeln(count mod p);

	close(input);
	close(output);
end.
