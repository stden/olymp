{$MODE DELPHI} {$O-}
procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'republic';

//////////////////////////////////////////////////////////////////////////
//                      Set system                                      //
//////////////////////////////////////////////////////////////////////////
var
  p,r,root :array [1..100000] of integer;

function ssparent (u :integer) :integer;
var
  t :integer;
begin
  result := u;
  while p[result]<>result do
    result := p[result];

  while p[u]<>u do
    begin
      t := p[u];
      p[u] := result;
      u := t;
    end;
end;

procedure ssmerge (v,u :integer);
begin
  v := ssparent(v);
  u := ssparent(u);

  if r[v]>r[u] then p[u]:=v else
  if r[u]>r[v] then p[v]:=u else
    begin
      p[v] := u;
      inc(r[u]);
    end;
end;

//////////////////////////////////////////////////////////////////////////
//                      Cyclic linked lists                             //
//////////////////////////////////////////////////////////////////////////

type
  pvertex = integer;

  pnode = ^tnode;
  tnode = record
    d :pvertex;
    n :pnode;
  end;

//Return last if list = (last)
function remove (last :pnode) :pnode;
begin
  result := last.n;
  last.n := result.n;
  result.n := result;
end;

procedure merge (l1,l2 :pnode);
var
  t :pnode;
begin
  t := l1.n;
  l1.n := l2.n;
  l2.n := t;
end;

function empty (list :pnode; v :pvertex) :boolean;
var
  p :pnode;
begin
  p := list.n;
  while p<>list do
    begin
      if (p.d<>0)and(root[ssparent(p.d)]<>v) then exit(false);
      p := p.n;
    end;
  exit(true);
end;

var
  avail :array [1..700002] of tnode;
  minavail :integer;

function alloc (d :pvertex) :pnode;
begin
  inc(minavail);
  result := @avail[minavail];
  result.d := d;
  result.n := result;
end;

//////////////////////////////////////////////////////////////////////////
//                      Graph                                           //
//////////////////////////////////////////////////////////////////////////

type
  tvertex = record
    color :(clBlack, clGray, clWhite);
    merged:boolean;
    c :integer;
    ls,le,lsr :pnode;
  end;

var
  vt :array [1..100000] of tvertex;
  n :integer;

procedure vmerge(v,u :pvertex);
begin
  ssmerge(v,u);
  root[ssparent(u)] := u;

  merge(vt[v].ls,  vt[u].ls);
  merge(vt[v].le,  vt[u].le);
  merge(vt[v].lsr, vt[u].lsr);

  vt[v].merged := true;
end;

//condensation
function dfsc (v :pvertex) :pvertex;
var
  n :pnode;
  u :pvertex;
begin
  if vt[v].merged then exit(0);

  if vt[v].color=clWhite then exit(0);
  if vt[v].color=clGray  then exit(v);
  vt[v].color := clGray;

  while vt[v].ls.n<>vt[v].ls do
    begin
      n := remove(vt[v].ls);

      if n.d=0 then continue; //merge trush
      n.d := root[ssparent(n.d)];
      if n.d=v then continue; //merge trush

      merge (vt[v].lsr,n);

      u := dfsc(n.d);

      if (u<>0) and (u<>v) then
        begin
          vmerge(v,u);
          exit(u);
        end;
    end;

  vt[v].color := clWhite;
  exit(0);
end;

//mark
function dfsm (v :integer; c :integer) :boolean;
var
  n :pnode;
begin
  if vt[v].merged then exit(false);
  if vt[v].c<>0 then exit(false);
  vt[v].c := c;

  n := vt[v].lsr.n;
  while n<>vt[v].lsr do
    begin
      n.d := root[ssparent(n.d)];
      if n.d<>0 then //merge trush
        dfsm(n.d,c);
      n := n.n;
    end;

  n := vt[v].le.n;
  while n<>vt[v].le do
    begin
      n.d := root[ssparent(n.d)];
      if n.d<>0 then //merge trush
        dfsm(n.d,c);
      n := n.n;
    end;

  exit(true);
end;

//////////////////////////////////////////////////////////////////////////
//                      Components                                      //
//////////////////////////////////////////////////////////////////////////

var
  cs,ce :array [0..100000] of pnode;
  cmax :integer;

//////////////////////////////////////////////////////////////////////////
//                      Main                                            //
//////////////////////////////////////////////////////////////////////////
var
  m,i,j,k1,k2,a,b :integer;
  us,ue :pvertex;
  ns,ne,ls,le :pnode;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    read(n,m);
    minavail := 0;
    for i := 1 to n do
      begin
        //set system
        p[i] := i;
        r[i] := 0;
        root[i] := i;

        //graph
        vt[i].ls     := alloc(0);
        vt[i].le     := alloc(0);
        vt[i].lsr    := alloc(0);
        vt[i].color  := clBlack;
        vt[i].merged := false;
        vt[i].c      := 0;
      end;

    for i := 1 to m do
      begin
        read(a,b);
        merge(vt[a].ls, alloc(b));
        merge(vt[b].le, alloc(a));
      end;

    for i := 1 to n do
      dfsc(i);

    cmax := 0;
    for i := 1 to n do
      if dfsm(i,cmax+1) then inc(cmax);

    for i := 1 to cmax do
      begin
        cs[i] := alloc(0);
        ce[i] := alloc(0);
      end;

    k1 := 0;
    k2 := 0;
    for i := 1 to n do
      if vt[i].c<>0 then
        begin
          if empty(vt[i].lsr,i) then
            begin
              inc(k1);
              merge(ce[vt[i].c], alloc(i));
            end;
          if empty(vt[i].le,i)  then
            begin
              inc(k2);
              merge(cs[vt[i].c], alloc(i));
            end;
        end;

    us := cs[1].n.d;
    ue := ce[1].n.d;

    if k1>k2 then writeln(k1) else writeln (k2);
    if (k1=0) and (k2=0) then halt;

    //merge components
    for i := 1 to cmax do
      begin
        j := i mod cmax + 1;

        ns := remove(cs[i]);
        ne := remove(ce[j]);

        writeln (ne.d, ' ', ns.d);
      end;

    //merge all
    ls := alloc(-1);
    le := alloc(-1);
    for i := 1 to cmax do
      begin
        merge(ls,cs[i]);
        merge(le,ce[i]);
      end;

    ns := ls;
    ne := le;
    repeat ns := ns.n until ns.d<>0;
    repeat ne := ne.n until ne.d<>0;

    while (ns<>ls) and (ne<>le) do
      begin
        writeln (ne.d, ' ', ns.d);
        repeat ns := ns.n until ns.d<>0;
        repeat ne := ne.n until ne.d<>0;
      end;

    while (ns<>ls) do
      begin
        writeln (ue, ' ', ns.d);
        repeat ns := ns.n until ns.d<>0;
      end;

    while (ne<>le) do
      begin
        writeln (ne.d, ' ',us);
        repeat ne := ne.n until ne.d<>0;
      end;
  halt;
end.
