// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O+,Q-,O2+}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='geology.in';
      StreamOut='geology.out';
      NMax=250000;
      XMax=110000;
      Root=1;
      Infinity=-1;
      Term:set of char=['A'..'Z'];
type
 integer=longint;
 IntVect=array [0..NMax] of int64;
 ExtVect=array [0..NMax] of extended;
 BoolVect=array [0..NMax] of boolean;
var Valid:BoolVect;
    Volume:ExtVect;
    Height,Delta:IntVect;
    Temp:extended;


procedure OpenFiles;
begin
 assign(input,StreamIn);
 reset(input);
 assign(output,StreamOut);
 rewrite(output)
end;

procedure CloseFiles;
begin
 close(input);
 close(output)
end;

function Sum2(r:extended):extended;
begin
 Result:=(r*(r+1))/2
end;

function Sum1(l,r:extended):extended;
begin
 if l>r then Result:=0
 else
  if l=r then Result:=2*l
  else Result:=2*(Sum2(r)-Sum2(l-1))
end;

function Sum(l,r:int64):extended;
var k:integer;
begin
 if l=r then Result:=0
 else begin
   if l>r then begin
     k:=l;
     l:=r;
     r:=k
    end;
   Result:=(Sum1(l+1,r-1)+l+r)/2
  end
end;

procedure Divide(Vert,l,r:integer);
var v:integer;
    q1,q2:extended;
begin
 v:=(l+r) div 2-l+1;
 if Valid[Vert] then begin
   Valid[2*Vert]:=True;
   Valid[2*Vert+1]:=True;
   Valid[Vert]:=False
  end;
 Delta[2*Vert]:=Delta[2*Vert]+Delta[Vert];
 Delta[2*Vert+1]:=Delta[2*Vert+1]+Delta[Vert];
 Height[2*Vert]:=Height[2*Vert]+Height[Vert];
 Height[2*Vert+1]:=Height[2*Vert+1]+Height[Vert]+Delta[Vert]*v;
 Delta[Vert]:=0;
 Height[Vert]:=0
end;

procedure AddToSegm(Vert,l,r,First,Value:integer);
var Temp,Change:integer;
    q:extended;
begin
  if Valid[Vert] then
  Volume[Vert]:=(Height[Vert]+Height[Vert]+Delta[Vert]*(r-l+1))/2;
 if (l<=(First+abs(Value)-1)) and (r>=First) then
  if (l>=First) and (r<=(First+abs(Value)-1)) then begin
    if Value>0 then begin
      Temp:=l-First;
      Change:=1
     end
    else begin
      Temp:=abs(Value)-(l-First);
      Change:=-1
     end;
    Height[Vert]:=Height[Vert]+Temp;
    Delta[Vert]:=Delta[Vert]+Change;
    q:=Sum(Temp,Temp+(r-l+1)*Change);
    Volume[Vert]:=Volume[Vert]+q
   end
  else begin
    Divide(Vert,l,r);
    AddToSegm(2*Vert,l,(l+r) div 2,First,Value);
    AddToSegm(2*Vert+1,(l+r) div 2+1,r,First,Value);
    Volume[Vert]:=Volume[2*Vert]+Volume[2*Vert+1]
   end
end;

procedure CalcVolume(Vert,l,r,x,y:integer);
var Go:extended;
begin
 if Valid[Vert] then
  Volume[Vert]:=(Height[Vert]+Height[Vert]+Delta[Vert]*(r-l+1))/2
 else
  Go:=Volume[Vert]+((2*Height[Vert]+Delta[Vert]*(r-l+1))*(r-l+1))/2;
 if (l<=y) and (r>=x) then
  if (l>=x) and (r<=y) then begin
    if Valid[Vert] then Temp:=Temp+Volume[Vert]
    else Temp:=Temp+Go
   end
  else begin
    Divide(Vert,l,r);
    CalcVolume(2*Vert,l,(l+r) div 2,x,y);
    CalcVolume(2*Vert+1,(l+r) div 2+1,r,x,y)
   end
end;

procedure Process;
var Ch,Com:char;
    p1,p2,i,k,n:integer;
begin
 for i:=1 to NMax do begin
   Valid[i]:=False;
   Volume[i]:=0;
   Height[i]:=0;
   Delta[i]:=0
  end;
 Valid[Root]:=True;
 read(n);
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
          AddToSegm(Root,1,XMax,p1-p2+1,p2);
          AddToSegm(Root,1,XMax,p1+1,-p2)
         end;
     'Y':begin
          if p1>p2 then begin
            k:=p1;
            p1:=p2;
            p2:=k
           end;
          Temp:=0;
          if p1<p2 then CalcVolume(Root,1,XMax,p1+1,p2);
          writeln(Temp:0:3)
         end
    end
  end
end;

begin
 OpenFiles;
 Process;
 CloseFiles
end.
