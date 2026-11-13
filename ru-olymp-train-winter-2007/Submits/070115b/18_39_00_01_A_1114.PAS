{$R-,Q-,S-}
type integer = longint;
var
	next:array [1..5000000] of integer;
	e:array[1..500000] of integer;
	first:array[1..5000000] of integer;
	dfsnum :array[1..500000] of integer;
	visited:array[1..500000] of boolean;
	posl:integer;
	ans:array[1..500000] of boolean;
	n,m:integer;

	currentdfsnum:integer;
	function dfs(i,from : integer) : integer;
   var
      top : integer;
      subnode_top : integer;
      p,t:integer;
   begin

      visited[i] := true;
      dfsNum[i] := currentDfsNum;
      inc(currentDfsNum);
      top := currentDfsNum;
      p:=first[i];
      while p<>0 do begin
      	if (e[p]=from) then begin
					p := next[p];
					continue;
      	end;
      	t := e[p];
	      if not visited[t] then begin
          subnode_top := dfs(t,i);
                  e[p] := t;
                  if subnode_top > dfsNum[i] then begin
                  	ans[(p+1)div 2]:=true;
                  end;
                  if subnode_top < top then begin
                     top := subnode_top;
                  end;
               end
               else begin
{                  if dfsNum[e[p]] > dfsNum[i] then begin
                  	ans[(p+1)div 2]:=true;
                  end;                                   }
                  if dfsNum[e[p]] < top then begin
                     top := dfsNum[e[p]];
                  end;
         end;
         p:= next[p];

      end;
      dfs := top;
   end;
var

	a,b,i,pos:integer;
begin
	assign(input,'bridges.in');
	reset(input);
	assign(output,'bridges.out');
	rewrite(output);
	fillchar(first,sizeof(first),0);
	read(n);
	read(m);
	pos := 1;
	for i:=1 to m do begin
		read(a,b);
		next[pos] := first[a];
		e[pos] := b;
		first[a]:=pos;
		inc(pos);
		next[pos] := first[b];
		e[pos] := a;
		first[b]:=pos;
		inc(pos);
	end;
	fillchar(dfsnum,sizeof(dfsnum),127);
	fillchar(visited,sizeof(visited),0);
	currentdfsnum:=0;
        fillchar(ans,sizeof(ans),0);
	for i:=1 to n do if (not visited[i]) then	dfs(i,-1);
	posl:=0;
        for i:=1 to m do begin
                if (ans[i]) then inc(posl);
	end;
        writeln(posl);
	for i:=1 to m do begin
		if (ans[i]) then writeln(i);
	end;
  close(input);
	close(output);
end.
