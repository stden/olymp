// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R+,H+,O-,Q-,O2-}
{$M 16000000}
{$MODE DELPHI}

uses Math;
const StreamIn='geology.in';
      StreamOut='geology.out';
      NMax=250000;
      XMax=1100;
      Root=1;
      Infinity=-1;
      Term:set of char=['A'..'Z'];
type
 integer=longint;
 IntVect=array [0..NMax] of int64;
 ExtVect=array [0..NMax] of extended;
 BoolVect=array [0..NMax] of boolean;
var X:IntVect;
    Temp:extended;

procedure Process;
var Ch,Com:char;
    p1,p2,i,k,j,n:integer;
begin
 read(n);
 for i:=0 to XMax do X[i]:=0;
 for i:=1 to n do begin
   read(Ch);
   while not (Ch in Term) do read(Ch);
   while Ch in Term do begin
     Com:=Ch;
     read(Ch)
    end;
   read(p1,p2);
   case Com of
     'D':begin
          for j:=0 to XMax do
           X[j]:=X[j]+Max(0,p2-abs(j-p1))
         end;
     'Y':begin
          if p1>p2 then begin
            k:=p1;
            p1:=p2;
            p2:=k
           end;
          Temp:=0;
          for j:=p1 to p2-1 do
           Temp:=Temp+(X[j]+X[j+1])/2;
          writeln(Temp:0:3)
         end
    end
  end
end;

begin
 assign(input,'input.txt');
 assign(output,'answer.txt');
 reset(input);
 rewrite(output);
 Process;
 close(input);
 close(output)
end.
