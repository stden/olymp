Program prg;

{$MINSTACKSIZE 100000}

const
  taskname = 'bridges';

type
  integer = longint;

var
  n, m: integer;
  i, j, k: integer;
  a, b: integer;
  t1, t2: array[0..200010] of integer;
  arr: array[0..400010] of integer;
  pt: array[0..400010] of integer;
  l, l2: array[0..20010] of integer;
  was: array[0..20010] of integer;
  bridge: array[0..400010] of boolean;
  res: integer;
  t: integer;


function dfs(v, par: integer): integer;
  var
    i, max, tmp: integer;

  begin
    max:=999999;
    was[v]:=t;
    for i:=l[v-1] to l[v]-1 do if arr[i] <> par then begin
      if (was[arr[i]] = 0) then begin
        inc(t);
        tmp:=dfs(arr[i], v);
        if (tmp <= was[v]) then begin
          bridge[pt[i]]:=false;
        end;
        if (tmp < max) then max:=tmp;
      end
      else begin
        tmp:=was[arr[i]];
        bridge[pt[i]]:=false;
        if (tmp < max) then max:=tmp;
      end;
    end;
    dfs:= max;
  end;


begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  read(n, m);
  for i:=1 to m do begin
    read(a, b);
    inc(l[a]);
    inc(l[b]);
    t1[i]:=a;
    t2[i]:=b;
  end;
  for i:=1 to n do begin
    l[i]:=l[i]+l[i-1];
  end;
  for i:=1 to n do l2[i]:=l[i-1];

  for i:=1 to m do begin
    arr[l2[t1[i]]]:=t2[i];
    pt[l2[t1[i]]]:=i;
    inc(l2[t1[i]]);
    arr[l2[t2[i]]]:=t1[i];
    pt[l2[t2[i]]]:=i;
    inc(l2[t2[i]]);
  end;

  for i:=1 to m do begin
    bridge[i]:=true;
  end;
  t:=2;
  dfs(1, 1);
  fillchar(was, sizeof(was), 0);
  t:=2;
  dfs(2, 2);
  for i:=1 to m do begin
    if (bridge[i]) then inc(res);
  end;
  writeln(res);
  for i:=1 to m do begin
    if (bridge[i]) then write(i, ' ');
  end;
  writeln;

  close(input);
  close(output);
end.
