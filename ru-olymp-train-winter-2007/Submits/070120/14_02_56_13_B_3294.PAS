{$Q-;R-;S-;I-;O+;H+}
{$mode delphi}
{$inline on}
const maxn = 25;
var g: array[1..maxn,1..maxn] of word;
    c,p,dnum: array[1..maxn] of word;
    d,w: array[1..maxn] of longint;
    n,m,k,a,b,i,depth,time: longint;
    best,noncycle: int64;

procedure bfs(s: longint);
var q: array[1..maxn] of longint;
    l,r,i,v: longint;
begin
	l := 1; r := 1;
	q[l] := s;
	d[s] := 0;
	w[s] := 0;
	while (l <= r) do
	begin
		v := q[l];
		for i:=1 to n do
			if (g[v,i]=1) and (d[v]+1<d[i]) then
			begin
				d[i] := d[v]+1;
				w[i] := w[v]+c[v];
				inc(r);
				q[r] := i;
			end;
		inc(l);
	end;
end;

procedure dfs(v: longint);
var u,q,b,fc,cc,cl,kk,i: longint;
    bv,cv: double;
begin
   inc(time); dnum[v] := time;
	inc(depth);
	inc(noncycle,c[v]);
	if (depth = k) and (noncycle > best) then
		best := noncycle;
	for u:=1 to n do
		if (g[v,u]=1) then
		begin
			if (dnum[u]<>0) and (dnum[u] <= dnum[v]) then
			begin
				q := v; b := 1; bv := -maxlongint;
				while (q <> p[u]) do
				begin
					if (q = 1) then
					begin
						b := 1; break;
					end;
					cv := w[q]/d[q];
					if (cv > bv) then
					begin
						bv := cv; b := q;
					end;
					q := p[q];
				end;
				q := v; cc := 0; cl := 0;
				while (q <> p[u]) do
				begin
					inc(cc,c[q]);
					inc(cl);
					q := p[q];
				end;

				kk := k;
				fc := w[b];
            dec(kk,d[b]-1);

				inc(fc,cc*(kk div cl));
				kk := kk mod cl;
				q := b;
				for i:=1 to kk do
				begin
					inc(fc,c[i]);
					q := p[q];
				end;
				if (fc > best) then best := fc;
			end;
         if (dnum[u]=0) then
			begin
				p[u] := v;
				dfs(u);
			end;
		end;
	dec(noncycle,c[v]);
	dec(depth);
end;

begin
	assign(input,'maxsum.in'); reset(input);
	read(n,m,k);
	for i:=1 to n do read(c[i]);
	for i:=1 to m do
	begin
		read(a,b);
		g[a,b] := 1;
	end;
	close(input);
	for i:=1 to n do d[i] := maxlongint div 3;
	bfs(1);
	fillchar(p,sizeof(p),0);
   fillchar(dnum,sizeof(dnum),0);
   time := 0;
	noncycle := 0; depth := -1;
	dfs(1);
	assign(output,'maxsum.out'); rewrite(output);
	writeln(best);
	close(output);
end.
