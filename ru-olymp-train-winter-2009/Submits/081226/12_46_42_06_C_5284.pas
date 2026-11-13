{$h+}
program
 P1;
var
 inp,oup:text;
 uk,uk2:longint;
 s,pr:string;
 fl:boolean;
begin
 assign(inp,'next.in');
 assign(oup,'next.out');
 reset(inp);
 rewrite(oup);
 while not eof(inp) do
 begin
 readln(inp,s);
 uk:=length(s);
 while s[uk]='1' do
  begin
   s[uk]:='0';
   dec(uk);
  end;
 s[uk]:='1';
 s[length(s)]:='1';
 uk:=2;
 fl:=false;
 while uk<length(s) do
  begin

   pr:=copy(s,uk,length(s)-uk+1);
   if s<pr then
    begin
     inc(uk);
     fl:=false;
     continue;
    end;
   uk2:=uk;
{   writeln(uk);
   writeln(uk2);
   writeln(s[uk2]);
   writeln(s[uk2-uk+1]);
   writeln(length(s));}
   while (uk2<length(s)) and (s[uk2]=s[uk2-uk+1]) do
    begin
   //  writeln('aaa');
     inc(uk2);
    end;
  // writeln(uk2);
   if uk2=length(s) then
    while s[uk2]='1' do
     begin
      dec(uk2);
    //  writeln('ooo');
     end;
   s[uk2]:='1';
   if (fl) and (uk2+1<>length(s)) then s[uk2+1]:='0';
   fl:=true;
  end;
 writeln(oup,s);
 end;
 close(inp);
 close(oup)
end.

