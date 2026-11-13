procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'bit';

var
  tc,ti :integer;
  l,i,j :integer;
  s   :array [0..100000] of byte;
  may :array [0..100000,1..3,1..2] of boolean; //1 - dorosti, 2 - virasti
  c :byte;
  ch :char;

function test :boolean;
begin
  fillchar(may,sizeof(may),0);
  may[0,1,1] := true;
  s[0] := 1;

  may[1,s[1],2] := true; //virasti s c(c) vsegda mogno
  for i := 2 to l do
    for j := 1 to 3 do
      begin
        //dorosti do j...
        if j=s[i-1] //$aa
          then may[i,j,1] := may[i - 1, j mod 3 + 1, 2] //virasti s $b.
                          or may[i - 1, j mod 3 + 2, 2] //virasti s $c.
                    //.$ba          |dorosti do $rba
          else may[i,j,1] := may[i-2,s[i-2],1]
                          or may[i-1,6-j-s[i-1],1] //dorosti do $.c.
                          or may[i-1,6-j-s[i-1],2]; //virasti s $.ca
        //virasti s j...
        if j=s[i]   //$.c(c)        |dorosti do $rc
          then may[i,j,2] := may[i-1,s[i-1],1]
                    //$.a(c)
          else may[i,j,2] := may[i-1,6-j-s[i],2]; //virasti s $bc
      end;
  exit(may[l,s[l],1]);
end;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    readln(tc);
    for ti := 1 to tc do
      begin
        readln(l);
        for i := 1 to l do
          begin
            read(ch);
            s[i] := ord(ch)-ord('a')+1;
          end;
        readln;

        if test then writeln('YES') else writeln('NO');
      end;
  halt;
end.
