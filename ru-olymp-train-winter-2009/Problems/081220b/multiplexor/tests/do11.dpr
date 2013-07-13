uses dogen, dorand;

label rep;

function std:extended; begin std:=1-fvd end;

const PS=32;
      MinR=30;
      MaxR=32;
      PackS=3000;

var i, j, Pr, RR:integer;
    tmp, t2:rule;

begin
  regint (11);
  for i:=1 to PS do begin
    rep:
    P[i]:=lr (0, 65535);
    for j:=1 to i-1 do if P[i]=P[j] then goto rep;
    RC[i]:=lr (MinR, MaxR);
    writeln ('A ', P[i]);
    for j:=1 to RC[i] do begin
      randrule (R[i, j], 0, 255, 64, 1, 5, 1, 5, 1, lnd, lnd, std);
      writerule (R[i, j]);
    end;
  end;
  writeln ('---');
  for i:=1 to PackS do begin
    Pr:=lr (1, PS);
    Rr:=lr (1, RC[Pr]);
    MatchingPacketbug2 (R[Pr, RR], tmp, 64);
    tmp.t.a:=P[Pr];                   
    Pr:=lr (1, PS);
    Rr:=lr (1, RC[Pr]);
    MatchingPacketbug2 (R[Pr, RR], t2, 64);
    t2.t.a:=P[Pr];
    case random (4) of
      0:tmp.f:=t2.f;
      1:tmp.t:=t2.t;
      2:tmp.i1:=t2.i1;
      3:tmp.p:=t2.p
    end;
    writepacket (tmp);
  end;
end.