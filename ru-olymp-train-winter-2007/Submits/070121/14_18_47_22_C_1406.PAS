{$Mode Delphi}
var n,i,maxx,maxy,maxi:integer;
    x:array[1..300000] of integer;
    y:array[1..300000] of integer;
    pos1,pos2,st1,st2:integer;
    res:integer;
    sign:extended;
    ans:array[1..300000] of record
                              i,j,k:integer;
                            end;



function vecmul(x1,y1,x2,y2:extended):extended;
begin
  vecmul:=x1*y2-x2*y1;
end;

function next(i:integer):integer;
begin
  i:=i+1;
  if i>n then i:=1;
  next:=i;
end;

function prev(i:integer):integer;
begin
  i:=i-1;
  if i<1 then i:=n;
  prev:=i;
end;

procedure findup(sign:extended);
var prev:integer;
begin
   prev:=pos1;
   pos1:=next(pos1);
   if vecmul(x[pos1]-x[prev],y[pos1]-y[prev],x[next(pos1)]-x[pos1],y[next(pos1)]-y[pos1])*sign>0 then begin
     prev:=pos1;
     pos1:=next(pos1);
   end;
end;

procedure finddown(sign:extended);
var next:integer;
begin
  next:=st1;
  if vecmul(x[pos2]-x[prev(pos2)],y[pos2]-y[prev(pos2)],x[next]-x[pos2],y[next]-y[pos2])*sign>0 then begin
    next:=pos2;
    pos2:=prev(pos2);
  end;
end;

procedure addtoans;
var t,tt:integer;
begin
  if y[pos2]>y[pos1] then begin
     t:=pos1;
     tt:=prev(pos1);
     while t<>st1 do begin
       inc(res);
       ans[res].i:=t;
       ans[res].j:=tt;
       ans[res].k:=pos2;
       t:=prev(t);
       tt:=prev(t);
     end;
     inc(res);
     ans[res].i:=st1;
     ans[res].j:=st2;
     ans[res].k:=pos2;
     t:=st2;
     tt:=prev(st2);
     while tt<>pos2 do begin
       inc(res);
       ans[res].i:=t;
       ans[res].j:=tt;
       ans[res].k:=pos2;
       t:=prev(t);
       tt:=prev(tt);
     end;
  end
  else begin
     t:=prev(pos1);
     tt:=prev(prev(pos1));
     while t<>st1 do begin
       inc(res);
       ans[res].i:=t;
       ans[res].j:=tt;
       ans[res].k:=pos1;
       t:=prev(t);
       tt:=prev(t);
     end;
     inc(res);
     ans[res].i:=st1;
     ans[res].j:=st2;
     ans[res].k:=pos1;
     t:=st2;
     tt:=prev(st2);
     while t<>pos2 do begin
       if tt=pos1 then break;
       inc(res);
       ans[res].i:=t;
       ans[res].j:=tt;
       ans[res].k:=pos1;
       t:=prev(t);
       tt:=prev(tt);
     end;
  end;
end;



begin
  assign(input,'tri.in');
  assign(output,'tri.out');
  reset(input);
  rewrite(output);
  readln(n);
  maxx:=-maxint;
  maxy:=0;
  maxi:=0;
  for i:=1 to n do
    read(x[i],y[i]);
  for i:=1 to n  do
    if (x[i]>maxx) or ((x[i]=maxx) and(y[i]>maxy) )  then begin
      maxx:=x[i];
      maxy:=y[i];
      maxi:=i;
    end;
  pos1:=maxi;
  pos2:=prev(maxi);
  while true do begin
    st1:=pos1;
    st2:=pos2;
    sign:=vecmul(x[pos1]-x[pos2],y[pos1]-y[pos2],x[next(pos1)]-x[pos1],y[next(pos1)]-y[pos1]);
    if sign=0 then
      sign:=vecmul(x[next(pos1)]-x[pos1],y[next(pos1)]-y[pos1],x[next(next(pos1))]-x[next(pos1)],y[next(next(pos1))]-y[next(pos1)]);
    findup(sign);
    if pos1=pos2 then begin
      addtoans;
      break;
    end;
    finddown(sign);
    if pos1=pos2 then begin
      addtoans;
      break;
    end;
    addtoans;
  end;
  for i:=1 to n-2 do
    writeln(ans[i].i,' ',ans[i].j,' ',ans[i].k);
  close(input);
  close(output);
end.
