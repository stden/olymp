procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'reverse';

var
  dig,s :array [-1..10000] of integer;
  i,j,k,t,l :integer;
  ch :char;

function _try (t :integer) :boolean;
begin
  if k=0 then
    exit(not odd(dig[0]));
  if k=1 then
    exit((dig[1]*10+dig[0]) mod 11 = 0);
  l := 0;
  for j := 0 to k div 2 do
    begin
      if dig[k-j]=dig[j]-l then
        begin
          s[j] := dig[j]-l + 10*t;
          if s[j]=19 then exit(false);
          l := (s[j]+l) div 10;
          t := 0;
          continue;
        end;
      if dig[k-j]=dig[j]-l+1 then
        begin
          s[j] := dig[j]-l + 10*t;
          if s[j]=19 then exit(false);
          l := (s[j]+l) div 10;
          t := 1;
          continue;
        end;
      exit(false);
    end;
  j := k div 2 + 1;
  exit((dig[k-j]-t-dig[j]+l+10) mod 10 = 0);
end;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
  repeat
    fillchar(dig,sizeof(dig),0);
    fillchar(s,sizeof(s),0);

    k := 0;
    while not eoln do
      begin
        read(ch);
        if ch=' ' then break;
        inc(k);
        s[k] := ord(ch)-ord('0');
      end;
    readln;
    //s: k..1
    if (k=1)and(s[1]=0) then break;

    for i := 0 to k-1 do
      dig[i] := s[k-i];
    dec(k);
    //dig: 0..k

    if _try(0) then writeln('YES') else
    if (dig[k]=1) and (k>0) then
      begin
        dig[k] := 0;
        dec(k);
        if _try(1) then writeln('YES') else writeln('NO');
      end else writeln('NO');

  until false;
  halt;
end.
