// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='cars.in';
      StreamOut='cars.out';
      NMax=11;
      XMax=6;
      VMax=1100000;
      Infinity=0;
      Root=1;
      NoSol=-1;
type
 integer=longint;
 IntState=array [0..NMax] of integer;
 CharState=array [0..NMax] of char;
 StructBor=array [0..VMax,0..XMax] of integer;
 IntVect=array [0..VMax] of integer;

var X,Y,State,CarType:IntState;
    Orient:CharState;
    Bor:StructBor;
    Mark,Queue,PrevV,PrevE,Last,Level:IntVect;
    n,VNum,SNum,Ql,Qr:integer;


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

function ReadChar:char;
begin
 read(Result);
 while not (Result in ['a'..'z']) do read(Result)
end;

procedure LoadCars;
var i:integer;
    c:char;
begin
 read(n);
 for i:=1 to n do begin
   Orient[i]:=ReadChar;
   read(X[i],Y[i]);
   c:=ReadChar;
   if c='c' then CarType[i]:=1
   else CarType[i]:=2
  end
end;

function AddToBor(Vert,Pos:integer; const State:IntState):boolean;
begin
 if Pos>n then begin
   if Mark[Vert]=Infinity then begin
     Result:=True;
     inc(SNum);
     Mark[Vert]:=SNum;
     Last[SNum]:=Vert
    end
   else Result:=False
  end
 else begin
   if Bor[Vert,State[Pos]]=Infinity then begin
     inc(VNum);
     if VNum>VMax then begin
       writeln(NoSol);
       CloseFiles;
       Halt(0)
      end;
     Bor[Vert,State[Pos]]:=VNum;
     PrevV[VNum]:=Vert;
     PrevE[VNum]:=State[Pos]
    end;
   Result:=AddToBor(Bor[Vert,State[Pos]],Pos+1,State)
  end
end;

procedure TakeFromBor(Vert,Pos:integer; var State:IntState);
begin
 if Pos>0 then begin
   State[Pos]:=PrevE[Vert];
   TakeFromBor(PrevV[Vert],Pos-1,State)
  end
end;

procedure AddPosition(const State:IntState; Prev:integer);
begin
 if AddToBor(Root,1,State) then begin
   Queue[Qr]:=SNum;
   if Prev<>Infinity then Level[SNum]:=Level[Prev]+1
   else Level[SNum]:=0;
   inc(Qr)
  end
end;

procedure TakePosition(var Temp:integer; var State:IntState);
begin
 Temp:=Queue[Ql];
 TakeFromBor(Last[Temp],n,State);
 inc(Ql)
end;

function Checked(const a,b:integer):boolean;
var i:integer;
begin
 Result:=True;
 for i:=1 to n do
  if Orient[i]='h' then begin
    if X[i]=a then
     if (State[i]<=b) and ((State[i]+CarType[i])>=b)
     then begin
       Result:=False;
       Exit
      end
   end
  else begin
    if Y[i]=b then
     if (State[i]<=a) and ((State[i]+CarType[i])>=a)
     then begin
       Result:=False;
       Exit
      end
   end
end;

function Winner(const State:IntState):boolean;
var i:integer;
begin
 Result:=True;
 for i:=State[1]+CarType[1]+1 to 6 do
  if not Checked(X[1],i) then begin
    Result:=False;
    Exit
   end
end;


procedure Solve;
var i,v,Temp,Save:integer;
begin
 Ql:=1;
 Qr:=1;
 VNum:=1;
 SNum:=0;
 fillchar(Mark,sizeof(Mark),Infinity);
 fillchar(Last,sizeof(Last),Infinity);
 fillchar(Bor,sizeof(Bor),Infinity);
 for i:=1 to n do
  if Orient[i]='h' then State[i]:=Y[i]
  else State[i]:=X[i];
 AddPosition(State,Infinity);
 while Ql<Qr do begin
   TakePosition(Temp,State);
   if Winner(State) then begin
     writeln(Level[Temp]+1);
     Exit
    end;
   for i:=1 to n do
    if Orient[i]='h' then begin
      Save:=State[i];
      v:=Save;
      while (v+CarType[i]+1)<=6 do begin
        if Checked(X[i],v+CarType[i]+1) then inc(v)
        else Break;
        State[i]:=v;
        AddPosition(State,Temp);
        State[i]:=Save
       end;
      v:=Save;
      while v>1 do begin
        if Checked(X[i],v-1) then dec(v)
        else Break;
        State[i]:=v;
        AddPosition(State,Temp);
        State[i]:=Save
       end
     end
    else begin
      Save:=State[i];
      v:=Save;
      while (v+CarType[i]+1)<=6 do begin
        if Checked(v+CarType[i]+1,Y[i]) then inc(v)
        else Break;
        State[i]:=v;
        AddPosition(State,Temp);
        State[i]:=Save
       end;
      v:=Save;
      while v>1 do begin
        if Checked(v-1,Y[i]) then dec(v)
        else Break;
        State[i]:=v;
        AddPosition(State,Temp);
        State[i]:=Save
       end
     end
  end;
 writeln(NoSol)
end;

begin
 OpenFiles;
 LoadCars;
 Solve;
 CloseFiles
end.
