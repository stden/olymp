{$MODE DELPHI}
{$R-,Q-,S-}
function max(a,b:int64):int64;
begin
	if (a>b) then result:=a
	else result:=b;
end;
function min(a:integer;b:int64):integer;
begin
	if (a>b) then result:=b
	else result:=a;
end;

var
	c:array[1..20] of integer;
	a:array[1..20,1..20] of boolean;
	d:array[1..40,1..40,0..120] of int64;
	n,m,i,j,li,lj,v,it,l,s,e,b:integer;
	ans,k:int64;
begin
	assign(input,'maxsum.in');
	reset(input);
	assign(output,'maxsum.out');
	rewrite(output);
	read(n,m,k);
	for i:=1 to n do read(c[i]);
	fillchar(a,sizeof(a),0);
	for i:=1 to m do begin
		read(b,e);
		a[b][e] := true;
	end;
	fillchar(d,sizeof(d),128);
	for i:=1 to n do d[i][i][0] := 0;
	for it:=1 to n do begin
		for v:=1 to n do begin
			for l:=1 to 3*n do begin
//				for s:=1 to n do begin
					for e:=1 to n do begin
						if (a[v][e]) then begin
              d[it][e][l] := max(d[it][e][l],d[it][v][l-1]+c[e]);
            end;
            if (d[1][1][1]=1) then writeln(it,' ',v,' ',e);
						//d[it][v][s]+d[v][e][l-s]);
					end;
//				end;
			end;
		end;
	end;
	ans:=0;
	for i:=1 to n do begin
		for li:=0 to 3*min(n,k) do begin
			for j:=1 to n do begin
				for lj:=1 to 3*min(n,k) do begin
//			for e:=1 to n do begin
						if (k<n) then ans := max(ans,d[1][i][k]);
						if ((d[1][i][li]>=0) and (d[i][i][lj]>=0)  and ((k-li) div lj>=0) and ((k-li) mod lj>=0) and (d[i][j][(k-li) mod lj]>=0)) then
            //31 i= 2 li=1 j=2 lj=1 last=0
            ans:=max(ans,
							d[1][i][li]+(d[i][i][lj]{-c[i]})*((k-li) div lj) + d[i][j][(k-li) mod lj]){-c[i]};
//              writeln(ans,' i= ',i,' li=',li,' j=',j,' lj=',lj,' last=',(k-li) mod lj);
//			end;
				end;
			end;
		end;
	end;
	writeln(ans+c[1]);
	close(input);
	close(output);
end.
