uses dogen, dorand;

label rep;

function std:extended; begin std:=1-sqd end;

const PS=32;
      MinR=32;
      MaxR=32;
      PackS=3000;

var i, j, Pr, RR:integer;
    tmp, t2:rule;

begin
  regint (17);
  for i:=1 to PS do begin
    rep:
    P[i]:=lr (0, 65535);
    for j:=1 to i-1 do if P[i]=P[j] then goto rep;
    RC[i]:=lr (MinR, MaxR);
    writeln ('A ', P[i]);
    for j:=1 to RC[i] do begin
      randrule (R[i, j], 0, 255, 5, 1, 1, 1, 1, 1, lnd, lnd, std);
      writerule (R[i, j]);
    end;
  end;
  writeln ('---');
  for i:=1 to PackS do begin
    Pr:=lr (1, PS);
    Rr:=lr (1, RC[Pr]);
    MatchingPacket (R[Pr, RR], tmp, 5);
    tmp.t.a:=P[Pr];                   
    Pr:=lr (1, PS);
    Rr:=lr (1, RC[Pr]);
    MatchingPacket (R[Pr, RR], t2, 5);
    t2.t.a:=P[Pr];
    case random (4) of
      0:tmp.f:=t2.f;
      1:tmp.t:=t2.t;
      2:tmp.i1:=t2.i1;
      3:tmp.p:=t2.p
    end;
    SmallTouch (R[Pr, RR], tmp, 5);
    writepacket (tmp);
  end;
end.