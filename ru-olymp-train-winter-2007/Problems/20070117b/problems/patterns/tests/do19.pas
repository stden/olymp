var i, j:integer;
    s:string;
begin
  s:='uronili.mishku.na.pol.otorvali.mishke.lapy.uhom.tresnuli.ob.vannu'+
     '.razdavili.glaz.steklyannyj.vskryli.nozhichkom.zhivotik'+
     '.rasporoli.mishke.rotik.vse.ravno.ego.ne.broshu.potomu.chto.on.horoshiy';
  for i:=1 to length (s) do begin
    for j:=1 to 10000 div length (s) -1 do write ('*');
    if random (55)=3 then write ('?') else write (s[i]);
  end;
  for j:=1 to 10000 div length (s) -1 do write ('*');
  writeln;
  writeln (s);
end.