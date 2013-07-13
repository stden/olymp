procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
  PEar = integer;
const
  filename = 'bit2';

var
  n :1..200;
  stat, nstat :array [0..199] of boolean; //STATE, 0..n-1
  k :1..5;
  tr :array [1..5,0..199] of byte; //TRANSFORMS, 1..k, 0..n-1
  //GRAPH of numbers
  flag :array [0..999] of boolean; //Has path to 0
  //GRAPH of pairs
  fe :array [0..199,0..199] of integer; //FROM ear - result of BFS
  head :array [0..199,0..199] of PEar; //Head of ears list
  ears :array [0..200*200*5{PEar}] of record //TEar
    x,y,t :byte; //x, y, transform
    next  :PEar;
    end; //of TEar
  maxe :integer;
  //QUEUE of pairs
  qx,qy :array [0..200*200] of byte; //QUEUE x, QUEUE y
  qs,qe :integer; //QUEUE start, QUEUE end

procedure Enqueue (x,y :byte);
begin
  inc(qe);
  qx[qe] := x;
  qy[qe] := y;
end;

procedure Dequeue (var x,y :byte);
begin
  inc(qs);
  x := qx[qs];
  y := qy[qs];
end;

procedure InitQueue;
begin
  qs := 0;
  qe := 0;
end;

function DoBFS :boolean; //... in GRAPH of numbers
var
  i,j :integer;
  x,y :byte;
begin
  fillchar(flag,sizeof(flag),0); //false
  InitQueue;
  Enqueue(0,0); //not use second param
  flag[0] := true;
  while qs<>qe do
    begin
      Dequeue(x,y); //not use second param
      for j := 1 to k do
        begin
          y := tr[j,x];
          if not flag[y] then
            begin
              Enqueue (y,0); //not use second param
              flag[y] := true;
            end;
        end;
    end;

  for i := 1 to n-1 do
    if not flag[i] then exit(false);
  exit(true);
end;

procedure BuildGraph2; //... of pairs
var
  xx,yy,tt,nx,ny :integer;
begin
  maxe := 0; //clear last GRAPH of pairs
  fillchar(head,sizeof(head),0);
  for xx := 0 to n-1 do
    for yy := 0 to n-1 do
      for tt := 1 to k do
        begin
          nx := tr[tt,xx];
          ny := tr[tt,yy];
          //Add ear to list at start
          inc(maxe);
          with ears[maxe] do
            begin
              x := xx;
              y := yy;
              t := tt;
              next := head[nx,ny];
            end;
          head[nx,ny] := maxe;
        end;
end;

function DoBFS2 :boolean; //... in GRAPH of pairs
var
  x,y :byte;
  e :PEar;
begin
  fillchar(fe, sizeof(fe),0);
  InitQueue;
  for x := 0 to n-1 do
    begin
      fe[x,x] := -1;

      Enqueue(x,x);
    end;
  while qs<>qe do
    begin
      Dequeue(x,y);
      e := head[x,y];
      while e<>0 do
        begin
          if (ears[e].x<>x) or (ears[e].y<>y) then
            if fe[ears[e].x,ears[e].y]=0 then
              begin
                Enqueue(ears[e].x,ears[e].y);
                fe[ears[e].x,ears[e].y] := ears[e].t;
              end;
          e := ears[e].next;
        end;
    end;
  for x := 0 to n-1 do
    for y := 0 to n-1 do
      if fe[x,y] = 0 then
        exit(false);
  exit(true);
end;

var
  tc,ti :integer; //Test count, Test iterator
  i,j :integer;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
  read(tc);
  for ti := 1 to tc do
    begin
      read(n,k);
      fillchar(stat,sizeof(stat),1); //true;
      for j := 1 to k do
        for i := 0 to n-1 do
          read(tr[j,i]);

      if not DoBFS then
        begin
          writeln('NO');
          continue;
        end;

      BuildGraph2;
      if not DoBFS2 then
        begin
          writeln('NO');
          continue;
        end;

      writeln('YES');
    end;
  halt;
end.
