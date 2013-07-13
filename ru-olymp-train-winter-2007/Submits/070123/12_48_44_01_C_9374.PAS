{$MODE DELPHI}
{$R+,Q+}
{$GOTO ON}
label cont;
const
	MAXN = 101;
	MAXK = 1000;
type
	matrix = array[0..maxn,0..maxn] of boolean;
	parent = array[0..maxn,0..maxn] of byte;
function getNbyChar(c:char):byte;
var
	r,i:byte;
begin
	if (c in ['0'..'9']) then begin
		r := ord(c)-ord('0');
	end;
	if (c in ['A'..'Z']) then begin
		r := ord(c)-ord('A')+10;
	end;
	if (c in ['a'..'z']) then begin
		r := ord(c)-ord('a')+36;
	end;
	if (c = '!') then begin
		r := 62;
	end;
	if (c = '?') then begin
		r := 63;
	end;
	result := r;
{for i:=5 downto 0 do begin
		result := result or ((r and 1) shl i);
		r := r shr 1;
	end;}
end;
var n:integer;
procedure mul(var a,b,c:matrix;var p:parent);
var i,j,k:integer;
begin
	fillchar(a,sizeof(a),0);
	for i:=0 to n-1 do begin
		for j:=0 to n-1 do begin
			for k:=0 to n-1 do begin
				if ((b[i][k] and c[k][j])) then begin
					a[i][j] := true;
					p[i][j] := k;
				end;
			end;
		end;
	end;	
end;

var
	b,c,d:matrix;
	par : array[0..maxn] of parent;
	source,color,q:array[0..maxn] of integer;
	ans:array[1..maxk,1..maxn*maxn] of integer;
procedure qsort(left,right:integer);
var m,tmp:integer;
	k,i,j:integer;
begin

 	i:=left;
	j:=right;
	m := q[(i+j) div 2];
	repeat
		while ((q[i]<m) ) do inc(i);
		while ((q[j]>m)) do dec(j);
		if (i<=j) then begin
			tmp := q[i];
			q[i] := q[j];
			q[j] := tmp;
			tmp := source[i];
			source[i] := source[j];
			source[j] := tmp;
      inc(i);
      dec(j);
		end;
	until i>=j;
	if (j>left) then qsort(left,j);
	if (i<right) then qsort(i,right);
end;

var
	k,p,r,pos,i,j,last,curpow,it,w:integer;
	a:array[0..10000000] of boolean;
	ch:char;
begin
	assign(input,'tourism.in');
	reset(input);
	assign(output,'tourism.out');
	rewrite(output);
	readln(n);
	pos:=-1;
	while not seekeoln do begin
		read(ch);
		r := getNbyChar(ch);
		for i:=0 to 5 do begin
			inc(pos);
 			a[pos] := (r and 1)=1;
 			//write(r and 1);
 			r := r shr 1;
		end;
	end;
	p:=0;
	for i:=0 to n-1 do begin
		for j:=i+1 to n-1 do begin
			d[i][j] := a[p+j-i-1];
			d[j][i] := not a[p+j-i-1];
		end;
		inc(p,n-i-1);
	end;
	for i:=0 to n-1 do begin
		for j:=0 to n-1 do begin
			b[i][j] := d[i][j];
    //  if (d[i][j]) then write('*') else write('.');
		end;
//    writeln;
	end;
	read(k);
	for i:=1 to k do begin
		read(q[i]);
		source[i] := i;
	end;
	qsort(1,k);
	curpow := 1;
	fillchar(par,sizeof(par),0);
	fillchar(ans,sizeof(ans),255);
	for it:=1 to k do begin
		while (curpow<q[it]-1) do begin
			mul(c,b,d,par[curpow+1]);
			b:=c;
			inc(curpow);
		end;
		for i:=0 to n-1 do begin
			for j:=0 to n-1 do begin
				if (b[i][j] and d[j][i]) then begin
					last := j;
					for w:=curpow+1 downto 2 do  begin
						ans[source[it]][w] := last;
						last := par[w-1][i][last];
					end;
					ans[source[it]][1] := i;
					goto cont;
				end;
			end;
		end;
		cont:
	end;
	for i:=1 to k do begin
		if (ans[i][1]<>-1) then begin
			j:=1;
			while (ans[i][j]<>-1) do begin
				write(ans[i][j],' ');
				inc(j);
			end;
			writeln;
		end
		else writeln(-1);
	end;
	close(input);
	close(output);
end.
