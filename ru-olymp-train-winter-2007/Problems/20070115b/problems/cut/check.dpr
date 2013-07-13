uses
  testlib, SysUtils;

const
  MAXN = 200;
  MAXM = MAXN * MAXN;

var
  i, j, k, l, m, n, p, s, t: longint;
  psum, ja, pa, pen: longint;
  v: array [0..MAXM] of longint;
  a: array [0..MAXN, 0..MAXN] of boolean;

function connected(x, y: longint): boolean;

var
  u: array [0..MAXN] of boolean;

  procedure visit(x: longint);
  var
    i: longint;
  begin
    u[x] := true;
    for i := 1 to n do
      if not u[i] and a[x][i] then
        visit(i);
  end;

begin
  fillchar(u, sizeof(u), 0);
  visit(s);
  connected := u[t];
end;

begin
  n := inf.readlongint;
  s := 1;
  t := n;
  m := inf.readlongint;

  ans.readlongint;
  ja := ans.readlongint;
  pen := ouf.readlongint;
  pa := ouf.readlongint;

  for i := 1 to pen do
  begin
    v[i] := ouf.readlongint;
    if (v[i] <= 0) or (v[i] > m) then
      quit(_wa, 'Удалено ребро, которого не было');
    if (i > 1) and (v[i - 1] >= v[i]) then
      quit(_wa, 'Ребра не упорядочены');
  end;

  p := 1;
  psum := 0;
  for i := 1 to m do
  begin
    j := inf.readlongint;
    k := inf.readlongint;
    l := inf.readlongint;
    if v[p] = i then
    begin
      inc(p);
      inc(psum, l);
    end
    else
    begin
      a[j][k] := true;
      a[k][j] := true;
    end;
  end;

  if psum <> pa then
    quit(_wa, 'Обещано удалить на сумму ' + inttostr(pa) + ', а удалено на ' + inttostr(psum));
  if connected(s, t) then
    quit(_wa, 'Сервера все еще соединены');

  if ja < pa then
    quit(_wa, 'Не оптимально: у жюри ' + inttostr(ja) + ' у участника ' + inttostr(pa));
  if ja > pa then
    quit(_fail, 'решение лучше чем у жюри: у жюри ' + inttostr(ja) + ' у участника ' + inttostr(pa));
  quit(_ok, '');
end.