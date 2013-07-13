{$MODE DELPHI}
{$R-,Q-}
const
        MAXN = 1000;
        MAXM = 10000;
var
	cl,first,first2,r :array[1..maxn] of integer;
	next,e,prev,b:array[1..maxm] of integer;
	u:array[1..maxn] of boolean;
	clc,n1,n2,m:integer;
	can:array[1..maxm] of boolean;

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
var
	count,tmpaa,tmpbb,p,aa,bb,i,pow:integer;
begin
	assign(input,'pairs.in');
	reset(input);
	assign(output,'pairs.out');
	rewrite(output);
	read(n1,n2,m);
	fillchar(first,sizeof(first),0);
	for i:=1 to m do begin
		read(aa,bb);
		next[i] := first[aa];
		prev[i] := first2[bb];
		first[aa] := i;
		first2[bb] := i;
		e[i] := bb;
		b[i] := aa;
	end;
	pow := 0;
	fillchar(r,sizeof(r),0);
	for i:=1 to n1 do begin
		fillchar(u,sizeof(u),0);
    if (dfs(i,true)) then inc(pow);
	end;
	{for i:=1 to n2 do begin
		if (r[i]<>0) then writeln(r[i],' ',i);
	end;}
	fillchar(can,sizeof(can),0);
	for i:=1 to n2 do begin
		p:=first2[i];
		while (p<>0) do begin
			if (b[p]=r[i]) then begin
				can[p] := true;
				break;
			end;
			p:= prev[p];
		end;
	end;	
	clc := 0;
	for i:=1 to m do begin
		if (can[i]) then begin
			inc(clc);
			cl[clc] := i;
		end;
	end;
	count := 0;
	for aa:=1 to clc do begin
		for bb:={cl[aa]+}1 to m do begin
      if ((can[bb]) and (bb<=aa)) then continue;
			tmpaa := e[cl[aa]];
			e[cl[aa]] := -1;
			tmpbb := e[bb];
			e[bb] := -1;
			p := 0;
			fillchar(r,sizeof(r),0);
			for i:=1 to n1 do begin
				fillchar(u,sizeof(u),0);
				if (dfs(i,true)) then begin
          inc(p);
        end;
			end;
			if (p<pow) then inc(count);
			e[cl[aa]]:=tmpaa;
			e[bb]:=tmpbb;
		end;
	end;
	writeln(count);
	close(input);
	close(output);
end.
