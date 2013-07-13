{$MODE DELPHI}
{$GOTO ON}
{$M 32000000}
label conti;
type integer = longint;
var
	p,r:array[1..100000] of integer;

function getp(v:integer):integer;
begin
	if (p[v]<>v) then begin
		p[v] := getp(p[v]);
	end;
	result := p[v];
end;

procedure union(a,b:integer);
begin
	if (r[a]<r[b]) then
		p[a] := b
	else if (r[a] > r[b]) then
		p[b] := a
	else begin
		if (random(2)=0) then begin
			p[a] := b;
			inc(r[b]);
		end
		else begin
			p[b] := a;
			inc(r[a]);
		end;
	end;
end;
var
	next,e:array[1..300000] of integer;
	first :array[1..100000] of integer;
	pos:integer;
	nextr,er:array[1..300000] of integer;
	firstr :array[1..100000] of integer;
	posr:integer;
	start:integer;
	ansa,ansb:array[1..300000] of integer;
	u:array[1..100000] of integer;
	anscount:integer;
procedure addans(a,b:integer);
begin
		inc(pos);
		next[pos] := first[a];
		e[pos] := b;
		first[a] := pos;
		inc(anscount);
		ansa[anscount] := a;
		ansb[anscount] := b;
end;
function dfs_cond(v:integer):boolean;
var
	p:integer;
	ok:boolean;
begin
	if (u[v]=2) then begin
		result:=false;
		exit;
	end;
	if (u[v]=1) then begin
                result:=true;
		exit;
	end;
	u[v] := 1;
{	if (getp(v) = getp(start)) then begin
//		result:= false;
		exit;
	end;}
	p:=first[v];
	result := false;
	while (p<>0) do begin
		if (getp(e[p]) = getp(start)) then begin
			result := true;
			p:=next[p];
			continue;
		end;
		ok := dfs_cond(e[p]);
		result := result or ok;
		if (ok) then begin
			union(getp(e[p]),getp(start));
		end;
		p := next[p];
	end;
	if (result) then u[v] := 2;
end;

procedure dfs(v:integer);
var
	p,count:integer;
begin
{	if (getp(v) = getp(start)) then begin
//		result:= false;
		exit;
	end;}
	union(getp(start),getp(v));
	p:=first[v];
	count := 0;
	while (p<>0) do begin
		if (getp(e[p]) = getp(start)) then begin
			p:=next[p];
			continue;
		end;
		dfs(e[p]);
		inc(count);
		p := next[p];
	end;
	if (count=0) then begin
		if (v<>start) then begin
			addans(v,start);
		end;
	end;
end;
var
	pp,n,m,a,b,i,j,prev:integer;
begin
	assign(input,'republic.in');
	reset(input);
	assign(output,'republic.out');
	rewrite(output);
	read(n,m);
	anscount:=0;
	for i:=1 to n do begin
		r[i]:=0;
		p[i]:=i;
	end;
	for i:=1 to m do begin
		read(a,b);
		inc(pos);
		next[pos] := first[a];
		e[pos] := b;
		first[a] := pos;
		inc(posr);
		nextr[posr] := firstr[b];
		er[posr] := a;
		firstr[b] := posr;
	end;
	fillchar(u,sizeof(u),0);
	for i:=1 to n do begin

		//if (getp(i)=i) then begin
		start := getp(i);
		dfs_cond(i);
{                for j:=1 to n do begin
		        writeln(j,' -> ',getp(j));
                end;}
		//end;
	end;
{	for j:=1 to n do begin
		writeln(j,' -> ',getp(j));
	end;}
  for i:=1 to n do begin
  	pp := firstr[i];
  	while (pp<>0) do begin
 			if (getp(i)<>getp(er[pp])) then begin
				goto conti;
			end;
  	  pp := nextr[pp];
  	end;
  	start := i;
		dfs(i);
		conti:
  end;
//writeln(1,' -> ',getp(1));
	prev := 1;
        for i:=2 to n do begin
//                for j:=1 to n do begin
//                        writeln(j,' -> ',getp(j));
//                end;
		//writeln(i,' -> ',getp(i));
		if (getp(prev) <> getp(i)) then begin
		  //writeln(getp(prev),',',getp(i));
			addans(prev,i);
      union(getp(prev),getp(i));
			prev := i;
		end;
	end;
	if (prev<>1) then begin
	        addans(prev,1);
	end;
	writeln(anscount);
	for i:=1 to anscount do begin
		writeln(ansa[i],' ',ansb[i]);
	end;
	close(input);
	close(output);
end.
