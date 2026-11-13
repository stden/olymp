var
 gg:extended;
 n,k,l,i:integer;
 s:string;
begin
 assign(input,'wordgame.in'); reset(input);
 assign(output,'wordgame.out'); rewrite(output);
 readln(k,n);
 readln(S);
 l:=length(S);
 gg:=1;
 for i:=1 to l do
  gg:=gg*k;
 gg:=gg*n;
 writeln(gg:0:6);
 close(input); close(output);
end.
