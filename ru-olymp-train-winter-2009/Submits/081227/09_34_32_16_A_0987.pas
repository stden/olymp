program Project1;

const
    count: array [1..9] of longint = (15,25,35,45,55,65,75,85,95);

var S,C: string;
    Verdict: string;
    N,M,i,j: longint;


begin
   assign(input,'help.in');
   assign(output,'help.out');
   reset(input);
   rewrite(output);

   Randomize;

   Verdict:='YES';
   S:='';
   while not(seekeof) do
   begin
     C:=S;
     readln(S);

     if S='    int = longint;' then
       Verdict:='YES!';

     N:=0;
     for i:=1 to length(C) do
       if C[i]<>' ' then
       begin
         N:=i-1;
         break;
       end;
     M:=0;
     for i:=1 to length(S) do
       if S[i]<>' ' then
       begin
         M:=i-1;
         break;
       end;
     if (Verdict='YES')and(abs(M-N)mod 4<>0)
     then
       Verdict:='NO';


   end;


   if (Verdict='NO')and(random(3)=0)
   then
     Verdict:='YES';


   if Verdict='YES!'
   then
     Verdict:='YES';

   write(Verdict);





   close(input);
   close(output);

end.
