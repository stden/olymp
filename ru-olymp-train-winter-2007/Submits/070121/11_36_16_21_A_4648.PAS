Program prg;

uses
  Math;

const
  taskname = 'geology';

type
  integer = longint;

  qq = record
    next: integer;
    x, y: integer;
  end;

function calc(x, y, x1, x2: integer): double;
  begin
    if (x1 < x-y) then x1:=x-y;
    if (x2 > x+y) then x2:=x+y;
    if (x1 > x) then begin
      calc:=0.5*(x+y-x1)*(y-(x1-x)) - 0.5*(x+y-x2)*(y-(x2-x));
    end else
    if (x2 < x) then begin
      calc:=0.5*(x2-(x-y))*(y-(x-x2)) - 0.5*(x1 - (x-y))*(y-(x-x1));
    end else
    calc:=y*y - 0.5*(x1-x+y)*(y-(x-x1)) - 0.5*(x + y - x2)*(y -(x2 - x));
  end;

var
  n: integer;
  i, j, k: integer;
  c: char;
  x, p: integer;
  x1, x2: integer;
  a: array[0..600100] of integer;
  trs: array[0..1000100] of qq;
  lst: array[0..600100] of integer;
  free: integer;

procedure addv(v, x, p: integer);
  begin
    if (a[v] = -1) then begin
      a[v]:=free;
      lst[v]:=free;
      trs[free].x:=x;
      trs[free].y:=p;
      inc(free);
    end else begin
      trs[lst[v]].next:=free;
      lst[v]:=free;
      trs[free].x:=x;
      trs[free].y:=p;
      inc(free);
    end;
  end;

procedure add(v, i, j, l, r, x, p: integer);

  begin
    if (r <= i) or (l >= j) then begin
      exit;
    end;
    if (r <= j) and (l >= i) then begin
      addv(v, x, p);
      exit;
    end;
    addv(v, x, p);
    add(2*v, i, j, l, (l+r) div 2, x, p);
    add(2*v+1, i, j, (l+r) div 2, r, x, p);
  end;

function query(v, i, j, l, r: integer): double;
  var
    res: double;
    u: integer;

  begin
    if (r <= i) or (l >= j) then begin
      query:=0;
      exit;
    end;
    if (r <= j) and (l >= i) then begin
      u:=a[v];
      res:=0;
      while (u <> -1) do begin
        res:=res+calc(trs[u].x, trs[u].y, l, r);
        u:=trs[u].next;
      end;
      query:=res;
      exit;
    end;
    query:=query(2*v, i, j, l, (l+r) div 2) + query(2*v + 1, i, j, (l+r) div 2, r);
  end;


begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  for i:=1 to 600100 do a[i]:=-1;
  for i:=1 to 1000100 do trs[i].next:=-1;

  readln(n);
  for i:=1 to n do begin
    read(c);
    if (c = 'A') then begin
      read(c);
      read(c);
      readln(x, p);
      add(1, max(x-p, 1), min(x+p, 100000), 1, 100000, x, p);
    end else
    if (c = 'Q') then begin
      read(c);
      read(c);
      read(c);
      read(c);
      readln(x1, x2);
      writeln(query(1, x1, x2, 1, 100000):0:3);
    end;
  end;

  close(input);
  close(output);
end.
