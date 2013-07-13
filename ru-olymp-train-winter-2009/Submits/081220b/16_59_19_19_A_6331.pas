{$H+}
Type TLong=Array[0..10001]of Integer;
Var s1,s2:String;
    i,l1,l2:Integer;
    g1,g2,g:TLong;
    min_ans:Boolean;
Procedure WriteLong(var g:TLong);
Var i:Integer;
Begin
  for i:=g[0] downto 1 do Write(g[i]);
End;
Procedure SubLong(var g1,g2,g:TLong);
Var z,i:Integer;
Begin
  z:=0;g[0]:=g1[0];
  for i:=1 to g1[0] do begin
    g[i]:=g1[i]-g2[i]+z;
    if g[i]<0 then begin z:=-1;g[i]:=g[i]+10 end else z:=0;
  end;
End;
function compare(var g1,g2:TLong):Integer;
var i:Integer;
begin
  if g1[0]>g2[0] then compare:=1;
  if g1[0]<g2[0] then compare:=-1;
  if g1[0]=g2[0] then begin
    i:=g1[0];
    while (g1[i]=g2[i])and(i>=1) do Dec(i);
    if i=0 then compare:=0;
    if (i<>0) then begin
      if g1[i]>g2[i] then compare:=1 else compare:=-1;
    end;
  end;
end;
Begin
  Assign(input,'aplusminusb.in');
  Assign(output,'aplusminusb.out');
  Reset(input);ReWrite(output);
  ReadLn(s1);ReadLn(s2);
  l1:=length(s1);l2:=length(s2);
  g1[0]:=l1;g2[0]:=l2;
  for i:=l1 downto 1 do g1[l1-i+1]:=ord(s1[i])-ord('0');
  for i:=l2 downto 1 do g2[l2-i+1]:=ord(s2[i])-ord('0');
  while (g1[0]>0) and (g1[g1[0]]=0) do Dec(g1[0]);
  while (g2[0]>0) and (g2[g2[0]]=0) do Dec(g2[0]);
  if (g1[0]=0)or(g2[0]=0) then begin
     if (g1[0]=0)and(g2[0]=0) then begin
        Write('0');halt;
     end;
     if (g1[0]=0)and(g2[0]<>0) then begin
        Write('-');WriteLong(g2);halt;
     end;
     if (g1[0]<>0)and(g2[0]=0) then begin
        WriteLong(g1);halt;
     end;
  end;
  min_ans:=false;
  case compare(g1,g2) of
    0:begin Write('0');halt;end;
    -1:begin
	min_ans:=true;
	g:=g1;g1:=g2;g2:=g;
       end;
  end;
  fillchar(g,sizeof(g),0);
  SubLong(g1,g2,g);
  while (g[0]>0) and (g[g[0]]=0) do Dec(g[0]);
  if g[0]=0 then begin
    Write('0');halt;
  end;if min_ans then Write('-');
  WriteLong(g);
End.