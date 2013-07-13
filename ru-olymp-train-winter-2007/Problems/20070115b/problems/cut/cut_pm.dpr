program hackers2;

uses
	sysutils;

const
  infile = 'cut.in';
  outfile = 'cut.out';
  maxn = 202;

var
  n, a, b: longint;
  nout: array[1..maxn]of longint;
  out: array[1..maxn, 1..maxn]of longint;
  width: array[1..maxn, 1..maxn]of longint;
  number: array[1..maxn, 1..maxn]of longint;
  thd: array[1..maxn, 1..maxn]of longint;
  cut: array[1..maxn]of longint;
  front: array[1..maxn]of longint;
  prev: array[1..maxn]of longint;
  how: array[1..maxn]of longint;
  res: longint;
  resnum: longint;
  resdel: array[1..maxn * maxn]of longint;
  frhead, frtail: longint;

procedure load;
var
  i, m, src, dst, wdt: longint;
begin
  assign(input, infile);
  reset(input);
  read(n, m);
  a := 1;
  b := n;
  fillchar(nout, sizeof(nout), 0);
  for i := 1 to m do if not seekeof then begin
    read(src, dst, wdt);
    inc(nout[src]);
    out[src][nout[src]] := dst;
    width[src][nout[src]] := wdt;
    number[src][nout[src]] := i;
    inc(nout[dst]);
    out[dst][nout[dst]] := src;
    width[dst][nout[dst]] := wdt;
    number[dst][nout[dst]] := i;
  end;
  close(input);
end;

function min(a, b: longint): longint;
begin
  if a<b then min := a else min := b;
end;

procedure getthread;
var
  cur, i: longint;
begin
  fillchar(thd, sizeof(thd), 0);
  repeat
    frhead := 2;
    frtail := 1;
    fillchar(cut, sizeof(cut), 0);
    cut[a] := maxlongint;
    front[frtail] := a;
    while frtail<frhead do begin
      cur := front[frtail];
      inc(frtail);
      for i := 1 to nout[cur] do if (thd[cur][i]<width[cur][i]) and (cut[out[cur][i]] = 0) then begin
        front[frhead] := out[cur][i];
        prev[out[cur][i]] := cur;
        how[out[cur][i]] := i;
        cut[out[cur][i]] := min(cut[cur], width[cur][i]-thd[cur][i]);
        inc(frhead);
      end;
    end;
    if cut[b]>0 then begin
      cur := b;
      while cur<>a do begin
        inc(thd[prev[cur]][how[cur]], cut[b]);
        for i := 1 to nout[cur] do if out[cur][i] = prev[cur] then dec(thd[cur][i], cut[b]);
        cur := prev[cur];
      end;
    end;
  until cut[b] = 0;
end;

procedure heapsort;
var
  cnum: longint;

procedure swap(a, b: longint);
var
  t: longint;
begin
  t := resdel[a];
  resdel[a] := resdel[b];
  resdel[b] := t;
end;

procedure flowup(a: longint);
begin
  while (a>1) and (resdel[a div 2]<resdel[a]) do begin
    swap(a, a div 2);
    a := a div 2;
  end;
end;

procedure flowdown(a: longint);
begin
  while ((2 * a <= cnum) and (resdel[2 * a]>resdel[a])) or ((2 * a + 1 <= cnum) and (resdel[2 * a + 1]>resdel[a])) do begin
    if (2 * a = cnum) or (resdel[2 * a]>resdel[2 * a + 1]) then begin
      swap(a, 2 * a);
      a := 2 * a;
    end else begin
      swap(a, 2 * a + 1);
      a := 2 * a + 1;
    end;
  end;
end;

begin
  for cnum := 1 to resnum do flowup(cnum);
  for cnum := resnum-1 downto 1 do begin
    swap(1, cnum + 1);
    flowdown(1);
  end;
end;

procedure solve;
var
  i, j: longint;
begin
  getthread;
  res := 0;
  resnum := 0;
  for i := 1 to n do if cut[i]>0 then
    for j := 1 to nout[i] do if cut[out[i][j]] = 0 then begin
      inc(res, width[i][j]);
      inc(resnum);
      resdel[resnum] := number[i][j];
    end;
  heapsort;
end;

procedure save;
var
  i: longint;
begin
  assign(output, outfile);
  rewrite(output);
  writeln(resnum, ' ', res);
  for i := 1 to resnum do begin
    if i>1 then write(' ');
    write(resdel[i]);
  end;
  writeln;
  close(output);
end;

begin
  load;
  solve;
  save;
end.
