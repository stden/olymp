// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R+,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='substr.in';
      StreamOut='substr.out';


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

type integer=longint;

var S:string;
    p:array [0..310000] of integer;
    i,k,m:integer;
    c:char;

begin
 OpenFiles;
 S:='';
 while not eof do begin
   read(c);
   if (ord(c) in [33..126]) and (c<>'*') then S:=S+c
   else
    if c='*' then begin
      m:=length(S);
      S:=S+chr(127)
     end
  end;
 fillchar(p,sizeof(p),0);
 k:=0;
 for i:=2 to length(S) do begin
   while (k>0) and (S[i]<>S[k+1]) do k:=p[k];
   if S[i]=S[k+1] then inc(k);
   p[i]:=k;
   if k=m
   then writeln(i-2*m)
  end;
 CloseFiles
end.
