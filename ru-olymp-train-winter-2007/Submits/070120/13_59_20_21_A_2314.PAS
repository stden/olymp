Program prg;

const
  taskname = 'beauty';

type
  integer = longint;

  vertex = record
    arr: array[0..25] of integer;
    c: integer;
  end;

var
  n: integer;
  i, j, k: integer;
  base: array[0..1000] of string;
  cost: array[0..1000] of integer;
  s: string;
  was: array[0..25] of boolean;
  c: char;
  gg: array[0..27] of char;
  ng, nb: integer;
  max: integer;
  maxs: string;
  p: array [0..100] of integer;
  t: string;


procedure check(f: string);
  var
    i, j, k, now: integer;

  begin
    now:=0;
    for j:=1 to nb do begin
      fillchar(p, sizeof(p), 0);
      k:=0;
      t:=base[j]+'#'+f;
      for i:=2 to length(t) do begin
        while (k > 0) and (t[k+1] <> t[i]) do k:=p[k];
        if (t[k+1] = t[i]) then inc(k);
        p[i]:=k;
        if (p[i] = length(base[j])) then inc(now, cost[j]);
      end;
    end;
    if (now > max) then begin
      max:=now;
      maxs:=f;
    end else
    if (now = max) and (f < maxs) then maxs:=f;
  end;

procedure dfs(v: integer; s: string);
  var
    i: integer;

  begin
    if (v = 0) then begin
      check(s);
      exit;
    end;
    for i:=1 to ng do begin
      dfs(v-1, s+gg[i]);
    end;
  end;

begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);
  readln(nb);
  maxs:=chr(ord('z') + 1);
  for i:=1 to nb do begin
    base[i]:='';
    read(c);
    while (c<>' ') do begin
      was[ord(c)-ord('a')]:=true;
      base[i]:=base[i]+c;
      read(c);
    end;
    readln(cost[i]);
  end;

  read(n);
  for i:=0 to 25 do begin
    if (was[i]) then begin
      inc(ng);
      gg[ng]:=chr(i+ord('a'));
    end;
  end;

  dfs(n, '');

  writeln(max);
  writeln(maxs);

  close(input);
  close(output);
end.
