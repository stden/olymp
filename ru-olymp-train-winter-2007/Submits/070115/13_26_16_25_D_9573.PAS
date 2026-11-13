program sh;
const tn='bit2';
var a,tc_suck_fuck_suck,tc_suck_fuck:longint;
    b:string;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(tc_suck_fuck);
 for tc_suck_fuck_suck:=1 to tc_suck_fuck do
 begin
  if tc_suck_fuck_suck mod 2=1 then writeln('NO') else writeln('YES');
 end;
 close(input);close(output);
end.
