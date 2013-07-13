{$M 16000000}
uses Math, SysUtils;
var
 degin,degout:array[0..100000] of longint;
 lin,lout:array[0..100000] of longint;
 solo:array[0..100000] of longint;
 nin,nout,nsolo:longint;
 a,b,n,m,i,j,t:longint;
begin
 randseed:=25566;
 fillchar(degin,sizeof(degin),0);
 fillchar(degout,sizeof(degout),0);
 assign(input,'republic.in');
 reset(input);
 assign(output,'republic.out');
 rewrite(output);
 read(n,m);
 for i:=1 to m do begin
  read(a,b);
  inc(degout[a]);
  inc(degin[b]);
 end;
 nin:=0;
 for i:=1 to n do
  if degin[i]=0 then begin
   inc(nin);
   lin[nin]:=i;

  end;
 nout:=0;
 for i:=1 to n do
  if degout[i]=0 then begin
   inc(nout);
   lout[nout]:=i;
  end;
 for i:=2 to nin do begin
  j:=1+random(i-1);
  t:=lin[j];
  lin[j]:=lin[i];
  lin[i]:=t;
 end;
 for i:=2 to nout do begin
  j:=1+random(i-1);
  t:=lout[j];
  lout[j]:=lout[i];
  lout[i]:=t;
 end;

 writeln(max(nin,nout));

 for i:=1 to min(nin,nout) do begin
  writeln(lout[i],' ',lin[i]);
 end;
 if nin<nout then begin
  for i:=nin+1 to nout do begin
   writeln(lout[i],' ',lin[1+random(nin)]);
  end;
 end else begin
  for i:=nout+1 to nin do begin
   writeln(lout[1+random(nout)],' ',lin[i]);
  end;
 end;
 close(input);
 close(output);
end.
