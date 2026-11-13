program  Project1;

var S1,S2,T,a11,a12,a21,a22,a31,b11,b12,b21,b22,b31: array [0..10000] of int64;
    N1,N2,N,i,j,Query,l,r,c3l,c3r,c2l,c2r,c1r,c1l,bR,bL,bM,bS: longint;
    E: int64;


begin
   assign(input,'digitsum.in');
   assign(output,'digitsum.out');

   reset(input);
   rewrite(output);

   S1[1]:=1;
   N1:=1;
   S2[1]:=2;
   N2:=1;
   while (N1<1000)or(N2<1000) do
   begin

     N:=0;
     for j:=1 to N1 do
       if S1[j]=1
       then
       begin
         T[N+1]:=1;
         T[N+2]:=1;
         T[N+3]:=2;
         T[N+4]:=1;
         T[N+5]:=2;
         N:=N+5;
       end
       else
       begin
         T[N+1]:=1;
         T[N+2]:=1;
         T[N+3]:=2;
         T[N+4]:=1;
         T[N+5]:=2;
         T[N+6]:=1;
         T[N+7]:=2;
         N:=N+7;
       end;
     for j:=1 to N do
       S1[j]:=T[j];
     N1:=N;

     N:=0;
     for j:=1 to N2 do
       if S2[j]=1
       then
       begin
         T[N+1]:=1;
         T[N+2]:=1;
         T[N+3]:=2;
         T[N+4]:=1;
         T[N+5]:=2;
         N:=N+5;
       end
       else
       begin
         T[N+1]:=1;
         T[N+2]:=1;
         T[N+3]:=2;
         T[N+4]:=1;
         T[N+5]:=2;
         T[N+6]:=1;
         T[N+7]:=2;
         N:=N+7;
       end;
     for j:=1 to N do
       S2[j]:=T[j];
     N2:=N;

   end;


   a11[0]:=0;
   for i:=1 to N1 do
     a11[i]:=a11[i-1]+S1[i];
   a12[0]:=0;
   for i:=1 to N2 do
     a12[i]:=a12[i-1]+S2[i];

   a21[0]:=0;
   for i:=1 to N1 do
     if S1[i]=1
     then
       a21[i]:=a21[i-1]+a11[N1]
     else
       a21[i]:=a21[i-1]+a12[N2];
   a22[0]:=0;
   for i:=1 to N2 do
     if S2[i]=1
     then
       a22[i]:=a22[i-1]+a11[N1]
     else
       a22[i]:=a22[i-1]+a12[N2];

   a31[0]:=0;
   for i:=1 to N1 do
     if S1[i]=1
     then
       a31[i]:=a31[i-1]+a21[N1]
     else
       a31[i]:=a31[i-1]+a22[N2];





   b11[0]:=0;
   for i:=1 to N1 do
     b11[i]:=b11[i-1]+1;
   b12[0]:=0;
   for i:=1 to N2 do
     b12[i]:=b12[i-1]+1;

   b21[0]:=0;
   for i:=1 to N1 do
     if S1[i]=1
     then
       b21[i]:=b21[i-1]+b11[N1]
     else
       b21[i]:=b21[i-1]+b12[N2];
   b22[0]:=0;
   for i:=1 to N2 do
     if S2[i]=1
     then
       b22[i]:=b22[i-1]+b11[N1]
     else
       b22[i]:=b22[i-1]+b12[N2];

   b31[0]:=0;
   for i:=1 to N1 do
     if S1[i]=1
     then
       b31[i]:=b31[i-1]+b21[N1]
     else
       b31[i]:=b31[i-1]+b22[N2];


   read(N);
   for Query:=1 to N do
   begin
     read(l,r);

     E:=0;

     bL:=0;
     bR:=N1;
     bS:=l;
     while bL+1<bR do
     begin
       bM:=(bL+bR) div 2;
       if b31[bM]>=bS
       then
         bR:=bM
       else
         bL:=bM;
     end;
     c3l:=bR;

     bL:=0;
     bR:=N1;
     bS:=r;
     while bL+1<bR do
     begin
       bM:=(bL+bR) div 2;
       if b31[bM]>=bS
       then
         bR:=bM
       else
         bL:=bM;
     end;
     c3r:=bR;

     E:=E+a31[c3r-1]-a31[c3l];

     {Left}
     if S1[c3l]=1
     then
     begin
       {S1[c3l]=1}
       bL:=0;
       bR:=N1;
       bS:=l-b31[c3l-1];
       while bL+1<bR do
       begin
         bM:=(bL+bR) div 2;
         if b21[bM]>=bS
         then
           bR:=bM
         else
           bL:=bM;
       end;
       c2l:=bR;

       E:=E+a21[N1]-a21[c2l];

       if S1[c2l]=1
       then
       begin
         {S1[c2l]=1}
         bL:=0;
         bR:=N1;
         bS:=l-b31[c3l-1]-b21[c2l-1];
         while bL+1<bR do
         begin
           bM:=(bL+bR) div 2;
           if b11[bM]>=bS
           then
             bR:=bM
           else
             bL:=bM;
         end;
         c1l:=bR;

         E:=E+a11[N1]-a11[c1l-1];
       end
       else
       begin
         {S1[c2l]=2}
         bL:=0;
         bR:=N2;
         bS:=l-b31[c3l-1]-b21[c2l-1];
         while bL+1<bR do
         begin
           bM:=(bL+bR) div 2;
           if b12[bM]>=bS
           then
             bR:=bM
           else
             bL:=bM;
         end;
         c1l:=bR;

         E:=E+a12[N2]-a12[c1l-1];
       end;

     end
     else
     begin
       {S1[c3l]=2}
       bL:=0;
       bR:=N2;
       bS:=l-b31[c3l-1];
       while bL+1<bR do
       begin
         bM:=(bL+bR) div 2;
         if b22[bM]>=bS
         then
           bR:=bM
         else
           bL:=bM;
       end;
       c2l:=bR;

       E:=E+a22[N2]-a22[c2l];

       if S2[c2l]=1
       then
       begin
         {S2[c2l]=1}
         bL:=0;
         bR:=N1;
         bS:=l-b31[c3l-1]-b22[c2l-1];
         while bL+1<bR do
         begin
           bM:=(bL+bR) div 2;
           if b11[bM]>=bS
           then
             bR:=bM
           else
             bL:=bM;
         end;
         c1l:=bR;

         E:=E+a11[N1]-a11[c1l-1];
       end
       else
       begin
         {S2[c2l]=2}
         bL:=0;
         bR:=N2;
         bS:=l-b31[c3l-1]-b22[c2l-1];
         while bL+1<bR do
         begin
           bM:=(bL+bR) div 2;
           if b12[bM]>=bS
           then
             bR:=bM
           else
             bL:=bM;
         end;
         c1l:=bR;

         E:=E+a12[N2]-a12[c1l-1];
       end;
     end;


     {Right}
     if S1[c3r]=1
     then
     begin
       {S1[c3r]=1}
       bL:=0;
       bR:=N1;
       bS:=r-b31[c3r-1];
       while bL+1<bR do
       begin
         bM:=(bL+bR) div 2;
         if b21[bM]>=bS
         then
           bR:=bM
         else
           bL:=bM;
       end;
       c2r:=bR;

       E:=E+a21[c2r-1];

       if S1[c2r]=1
       then
       begin
         {S1[c2r]=1}
         bL:=0;
         bR:=N1;
         bS:=r-b31[c3r-1]-b21[c2r-1];
         while bL+1<bR do
         begin
           bM:=(bL+bR) div 2;
           if b11[bM]>=bS
           then
             bR:=bM
           else
             bL:=bM;
         end;
         c1r:=bR;

         E:=E+a11[c1r];
       end
       else
       begin
         {S1[c2r]=2}
         bL:=0;
         bR:=N2;
         bS:=r-b31[c3r-1]-b21[c2r-1];
         while bL+1<bR do
         begin
           bM:=(bL+bR) div 2;
           if b12[bM]>=bS
           then
             bR:=bM
           else
             bL:=bM;
         end;
         c1r:=bR;

         E:=E+a12[c1r];
       end;

     end
     else
     begin
       {S1[c3r]=2}
       bL:=0;
       bR:=N2;
       bS:=r-b31[c3r-1];
       while bL+1<bR do
       begin
         bM:=(bL+bR) div 2;
         if b22[bM]>=bS
         then
           bR:=bM
         else
           bL:=bM;
       end;
       c2r:=bR;

       E:=E+a22[c2r-1];

       if S2[c2r]=1
       then
       begin
         {S2[c2r]=1}
         bL:=0;
         bR:=N1;
         bS:=r-b31[c3r-1]-b22[c2r-1];
         while bL+1<bR do
         begin
           bM:=(bL+bR) div 2;
           if b11[bM]>=bS
           then
             bR:=bM
           else
             bL:=bM;
         end;
         c1r:=bR;

         E:=E+a11[c1r];
       end
       else
       begin
         {S2[c2r]=2}
         bL:=0;
         bR:=N2;
         bS:=r-b31[c3r-1]-b22[c2r-1];
         while bL+1<bR do
         begin
           bM:=(bL+bR) div 2;
           if b12[bM]>=bS
           then
             bR:=bM
           else
             bL:=bM;
         end;
         c1r:=bR;

         E:=E+a12[c1r];
       end;




     end;

     writeln(E);


   end;


   close(input);
   close(output);

end.
