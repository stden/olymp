uses dogen, dorand;

label rep;

function std:extended; begin std:=1-fvd end;

const PS=2;
      MinR=2;
      MaxR=2;
      PackS=100;

var i, j, Pr, RR:integer;
    tmp:rule;

begin
  regint (10);
  for i:=1 to PS do begin
    rep:
    P[i]:=lr (0, 65535);
    for j:=1 to i-1 do if P[i]=P[j] then goto rep;
    RC[i]:=lr (MinR, MaxR);
    writeln ('A ', P[i]);
    for j:=1 to RC[i] do begin
      randrule (R[i, j], 0, 255, 10, 1, 1, 1, 1, 1, lnd, lnd, std);
      writerule (R[i, j]);
    end;
  end;
  writeln ('---');
  for i:=1 to PackS do begin
    Pr:=lr (1, PS);
    Rr:=lr (1, RC[Pr]);
    MatchingPacketbug2 (R[Pr, RR], tmp, 10);
    writepacket (tmp);
  end;
end.