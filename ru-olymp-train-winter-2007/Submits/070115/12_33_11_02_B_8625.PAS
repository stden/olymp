// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

uses SysUtils;

const StreamIn='reverse.in';
      StreamOut='reverse.out';
      Last='0';
      Answer:array [False..True] of string=('NO','YES');
      NMax=11000;
type
 integer=longint;
 IntVect=array [0..NMax] of integer;
var X:IntVect;
    S:string;


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

procedure Process;
var t1,t2,t3,t4,v1,v2,v3,v4:boolean;
    l,r,n,i:integer;

 procedure Iterator;
 var i,j:integer;
 begin
  while l<=r do begin
    v1:=False;
    v2:=False;
    v3:=False;
    v4:=False;
    if l=r then begin
      for i:=0 to 9 do begin
        if t1 then
         if 2*i=X[l] then v1:=True;
        if t2 then
         if ((2*i+1) div 10=0) and
            ((2*i+1) mod 10=X[l])
         then v1:=True;
        if t4 then
         if ((2*i+1) div 10=1) and
            ((2*i+1) mod 10=X[l])
         then v1:=True
       end
     end
    else begin
      for i:=0 to 9 do
       for j:=i to 9 do begin
         if t1 then
          if (i+j) div 10=0 then begin
            if ((i+j) mod 10=X[l]) and
               ((i+j) mod 10=X[r])
            then v1:=True;
            if ((i+j+1) mod 10=X[l]) and
               ((i+j) mod 10=X[r])
            then
             if (i+j+1) div 10=0 then v3:=True;
           end;
         if t2 then
          if (i+j) div 10=0 then begin
            if ((i+j) mod 10=X[l]) and
               ((i+j+1) mod 10=X[r])
            then
             if (i+j+1) div 10=0 then v1:=True
             else v2:=True;
            if ((i+j+1) mod 10=X[l]) and
               ((i+j+1) mod 10=X[r])
            then
             if (i+j+1) div 10=0 then v3:=True
           end;
         if t3 then begin
           if (i+j) div 10=1 then
            if ((i+j) mod 10=X[l]) and
               ((i+j) mod 10=X[r])
            then v2:=True;
           if (i+j+1) div 10=1 then
            if ((i+j+1) mod 10=X[l]) and
               ((i+j) mod 10=X[r])
            then
             if (i+j) div 10=0 then v3:=True
             else v4:=True
          end;
         if t4 then begin
           if (i+j) div 10=1 then
            if ((i+j) mod 10=X[l]) and
               ((i+j+1) mod 10=X[r])
            then v2:=True;
           if (i+j+1) div 10=1 then
            if ((i+j+1) mod 10=X[l]) and
               ((i+j+1) mod 10=X[r])
            then v4:=True
          end
        end
     end;
    inc(l);
    dec(r);
    t1:=v1;
    t2:=v2;
    t3:=v3;
    t4:=v4
   end;
 end;

begin
 readln(S);
 while S<>Last do begin
   n:=length(S);
   for i:=1 to n do
    X[i]:=StrToInt(S[i]);
   t1:=True;
   t2:=False;
   t3:=False;
   t4:=False;
   l:=1; r:=n;
   Iterator;
   if (not (t1 or t4)) and (X[1]=1)
   then begin
     t1:=False;
     t2:=False;
     t3:=True;
     t4:=False;
     l:=2; r:=n;
     Iterator
    end;
   writeln(Answer[t1 or t4]);
   readln(S)
  end
end;

begin
 OpenFiles;
 Process;
 CloseFiles
end.
