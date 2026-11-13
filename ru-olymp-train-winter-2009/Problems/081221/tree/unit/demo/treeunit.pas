unit
  treeunit;

interface

procedure init;
function getN: longint;
function getA(edgeNum: longint): longint;
function getB(edgeNum: longint): longint;
function query(edgeNum: longint): longint;
procedure report(vertexNum: longint);

implementation

uses
  SysUtils;

const
  inputFile = 'input.txt';
  outputFile = 'output.txt';
  maxN = 200000;
  maxD = 5;
  maxQ = 100;

type
  Edge = record
    v, n: longint;
  end;

var
  inf: text;
  n, i, secret, ne, numQ: longint;
  a, b, p, f, depth, deg: array [1 .. maxN] of longint;
  e: array [1 .. 2 * maxN] of Edge;
  initialized: boolean;

procedure reportError(reason: string);
begin
  writeln(reason);
  halt(0);
end;

procedure init;
begin
  writeln('init()');
  if initialized then
    reportError('already initialized');
  initialized := true;
end;

function getN: longint;
begin
  writeln('getN()');
  if not initialized then
    reportError('not initialized');
  getN := n;
end;

function getA(edgeNum: longint): longint;
begin
  writeln('getA(' + inttostr(edgeNum) + ')');
  if not initialized then
    reportError('not initialized');
  if (edgeNum < 1) or (edgeNum >= n) then
    reportError('invalid call: getA(' + intToStr(edgeNum) + ')');
  getA := a[edgeNum];
end;

function getB(edgeNum: longint): longint;
begin
  writeln('getB(' + inttostr(edgeNum) + ')');
  if not initialized then
    reportError('not initialized');
  if (edgeNum < 1) or (edgeNum >= n) then
    reportError('invalid call: getB(' + intToStr(edgeNum) + ')');
  getB := b[edgeNum];
end;

function query(edgeNum: longint): longint;
begin
  writeln('query(' + inttostr(edgeNum) + ')');
  if not initialized then
    reportError('not initialized');
  if (edgeNum < 1) or (edgeNum >= n) then
    reportError('invalid call: query(' + intToStr(edgeNum) + ')');
  inc(numQ);
  if numQ > maxQ then
    reportError('too many queries: ' + inttostr(numQ));
  if (depth[a[edgeNum]] < depth[b[edgeNum]]) then
    query := 0
  else query := 1;
end;

procedure report(vertexNum: longint);
begin
  writeln('report(' + inttostr(vertexNum) + ')');
  if not initialized then
    reportError('not initialized');
  if (vertexNum < 1) or (vertexNum > n) then
    reportError('invalid call: report(' + intToStr(vertexNum) + ')');
  if (vertexNum = secret) then
    writeln('ok: ' + inttostr(numQ) + ' queries')
  else
    writeln('wa: ' + inttostr(secret) + ' expected, but ' + inttostr(vertexNum) + ' found');
  halt(0);
end;

function get(x: longint): longint;
begin
  if (x <> p[x]) then
    p[x] := get(p[x]);
  get := p[x];
end;

procedure unite(x, y: longint);
begin
  x := get(x);
  y := get(y);
  if (random(2) = 0) then
    p[x] := y
  else
    p[y] := x;
end;

procedure addEdge(a, b: longint);
begin
  inc(ne);
  e[ne].v := b;
  e[ne].n := f[a];
  f[a] := ne;
  inc(ne);
  e[ne].v := a;
  e[ne].n := f[b];
  f[b] := ne;
end;

procedure dfs(x, p, d: longint);
var
  cur: longint;
begin
  depth[x] := d;
  cur := f[x];
  while cur <> 0 do
  begin
    if e[cur].v <> p then
      dfs(e[cur].v, x, d + 1);
    cur := e[cur].n;
  end;
end;

begin
  initialized := false;
  randseed := $dead;
  {$I-}
  assign(inf, inputFile);
  reset(inf);
  if ioresult <> 0 then
    reportError('input file not found');
  read(inf, n);
  if (n < 1) or (n > maxN) then
    reportError('invalid n: ' + inttostr(n));
  for i := 1 to n do
  begin
    p[i] := i;
    f[i] := 0;
    deg[i] := 0;
  end;
  for i := 1 to n - 1 do
  begin
    read(inf, a[i], b[i]);
    if (a[i] < 1) or (a[i] > n) then
      reportError('invalid a[' + inttostr(i) + ']: ' + inttostr(a[i]));
    if (b[i] < 1) or (b[i] > n) then
      reportError('invalid b[' + inttostr(i) + ']: ' + inttostr(b[i]));
    if (get(a[i]) = get(b[i])) then
      reportError('invalid graph: not a tree');
    unite(a[i], b[i]);
    addEdge(a[i], b[i]);
    inc(deg[a[i]]);
    inc(deg[b[i]]);
  end;
  for i := 1 to n do
  begin
    if deg[i] > maxD then
      reportError('invalid degree of vertex ' + inttostr(i) + ': ' + inttostr(deg[i]));
  end;
  read(inf, secret);
  if (secret < 1) or (secret > n) then
    reportError('invalid secret: ' + inttostr(secret));
  close(inf);
  dfs(secret, 0, 0);
  numQ := 0;
end.
