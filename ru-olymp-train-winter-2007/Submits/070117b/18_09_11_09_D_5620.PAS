procedure helt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'patterns';

var
  t,p :array [0..10000] of char;
  stat :array [0..10000] of boolean;
  tm,pm :integer;
  i,j :integer;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    pm := 0;
    tm := 0;
    while not eoln do
      begin
        inc(pm);
        read(p[pm]);
      end;
    readln;

    while not eoln do
      begin
        inc(tm);
        read(t[tm]);
      end;
    readln;

    stat[0] := true;
    for i := 1 to pm do
      begin
        if p[i]='*'
          then
            for j := 1 to tm do
              stat[j]:=stat[j] or stat[j-1]
          else
            for j := tm downto 1 do
              stat[j]:=stat[j-1] and ((p[i]=t[j])or(p[i]='?'));
        if p[i]<>'*' then stat[0] := false;
      end;

    if stat[tm] then writeln('YES') else writeln ('NO');
  helt;
end.
