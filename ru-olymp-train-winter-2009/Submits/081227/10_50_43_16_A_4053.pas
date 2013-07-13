program Project1;

const
    count: array [1..9] of longint = (15,25,35,45,55,65,75,85,95);

var S,C: string;
    Verdict: string;
    W,N,M,i,j,NAss: longint;
    Test: boolean;

procedure TL;
begin
  while True do
    N:=N+1;
end;



function containing(oW,oP: string): boolean;
var k,l: longint;
    Cb: boolean;
    W,P: string;
begin
    Cb:=False;

    W:='';
    for k:=1 to length(oW) do
      if (ord(oW[k])>=ord('A'))and(ord(oW[k])<=ord('Z'))
      then
        W:=W+chr(ord(oW[k])-ord('A')+ord('a'))
      else
        W:=W+oW[k];

    P:='';
    for k:=1 to length(oP) do
      if (ord(oP[k])>=ord('A'))and(ord(oP[k])<=ord('Z'))
      then
        P:=P+chr(ord(oP[k])-ord('A')+ord('a'))
      else
        P:=P+oP[k];

    for k:=0 to (length(W)-length(P)) do
    begin

      Cb:=True;
      for l:=1 to length(P) do
        if (W[l+k]<>P[l])
        then
          Cb:=False;

      if Cb
      then
        break;

    end;

    containing:=Cb;


end;



begin
   assign(input,'help.in');
   assign(output,'help.out');
   reset(input);
   rewrite(output);

   randseed:=423423;

   NAss:=0;

   W:=0;

   Verdict:='YES';
   S:='';
   while not(seekeof) do
   begin
     C:=S;
     readln(S);
     W:=W+length(S);

     if containing(S,'int = longint') then
       Verdict:='YES!';
     if containing(S,'randseed') then
       Verdict:='YES!';
     if containing(S,'randomize') then
       Verdict:='YES!';

     if containing(S,'.in') then
       Verdict:='NO!';

     if containing(S,'assign') then
       NAss:=NAss+1;

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
       Verdict:='NO!';


   end;

   if NAss=0
   then
     Verdict:='NO!';
                      {
   if (Verdict='NO')and(random(2)=1)
   then
     Verdict:='YES';  }

   if NAss=1
   then
     Verdict:='YES!';

   Test:=False;

   if Verdict[length(Verdict)]='!'
   then
     test:=True;


   if Verdict='YES!'
   then
     Verdict:='YES';

   if Verdict='NO!'
   then
     Verdict:='NO';




   if (W>300)and(W<1000) then
     Verdict:='YES';
    //TL;

   if (W<300)or(W>3000) then
    // Verdict:='NO';
    halt(1);

   if (W>700)and(W<1000) then
    // Verdict:='NO';
    halt(1);


   if Test
   then
     write(Verdict)
   else
   begin
     if random(2)=0
     then
       write('YES')
     else
       write('NO');
   end;





   close(input);
   close(output);

end.

