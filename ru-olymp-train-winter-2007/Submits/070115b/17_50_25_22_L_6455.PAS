var p:array[1..20000] of char;
    q:array[1..200000] of char;
    pref:array[1..20000] of integer;
    i,j,n,m,k:integer;

procedure readp;
var ch:char;
begin
  while true do begin
    read(ch);
    if ch='*' then break;
    if (ord(ch)>32) and (ord(ch)<127) then begin
      inc(n);
      p[n]:=ch;
    end;
  end;
end;

procedure readq;
var ch:char;
begin
  while not seekeof do begin
    read(ch);
    if (ord(ch)>32) and (ord(ch)<127) then begin
      inc(m);
      q[m]:=ch;
    end;
  end;
end;

procedure pf;
var q:integer;
begin
  pref[1]:=0;
  q:=0;
  for i:=2 to n do begin
    while (q>0) and (p[q+1]<>p[i]) do q:=pref[q];
    if (p[q+1]=p[i]) then inc(q);
    pref[i]:=q;
  end;
end;

begin
  assign(input,'substr.in');
  assign(output,'substr.out');
  reset(input);
  rewrite(output);
  readp;
  readq;
  pf;
  k:=0;
  for i:=1 to m do begin
    while (k>0) and (p[k+1]<>q[i]) do k:=pref[k];
    if (p[k+1]=q[i]) then inc(k);
    if k=n then begin
      writeln(i-n+1);
      k:=pref[k];
    end;
  end;
  close(input);
  close(output);
end.
