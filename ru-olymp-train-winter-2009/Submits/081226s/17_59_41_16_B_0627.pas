program  Project1;

var P,K,A,bl,x,F,tP,Z: int64;
    i,j,Nd,pk,tp2N,vc,uc,N,NN,u,v: longint;
    Drider: array [1..100000] of longint;
    Matches: boolean;
    tp2: array [1..1000] of longint;
    Uresult,Vresult: array [1..100000,0..1] of int64;
    Ans: array [1..100000] of int64;




procedure AQsort(l,r: longint);
var Xm,T: int64;
    uu,vv: longint;
begin
    uu:=l;
    vv:=r;
    Xm:=Ans[(l+r)div 2];

    while uu<=vv do
    begin

      while Ans[uu]<Xm do uu:=uu+1;
      while Ans[vv]>Xm do vv:=vv-1;

      if uu<=vv then
      begin
        T:=Ans[uu];
        Ans[uu]:=Ans[vv];
        Ans[vv]:=T;

        uu:=uu+1;
        vv:=vv-1;
      end;

    end;

    if uu<r then AQsort(uu,r);
    if vv>l then AQsort(l,vv);

end;


procedure VQsort(l,r: longint);
var Xm,T: int64;
    uu,vv: longint;
begin
    uu:=l;
    vv:=r;
    Xm:=Vresult[(l+r)div 2,0];

    while uu<=vv do
    begin

      while Vresult[uu,0]<Xm do uu:=uu+1;
      while Vresult[vv,0]>Xm do vv:=vv-1;

      if uu<=vv then
      begin
        T:=Vresult[uu,0];
        Vresult[uu,0]:=Vresult[vv,0];
        Vresult[vv,0]:=T;

        T:=Vresult[uu,1];
        Vresult[uu,1]:=Vresult[vv,1];
        Vresult[vv,1]:=T;

        uu:=uu+1;
        vv:=vv-1;
      end;

    end;

    if uu<r then VQsort(uu,r);
    if vv>l then VQsort(l,vv);

end;



procedure UQsort(l,r: longint);
var Xm,T: int64;
    uu,vv: longint;
begin
    uu:=l;
    vv:=r;
    Xm:=Uresult[(l+r)div 2,0];

    while uu<=vv do
    begin

      while Uresult[uu,0]<Xm do uu:=uu+1;
      while Uresult[vv,0]>Xm do vv:=vv-1;

      if uu<=vv then
      begin
        T:=Uresult[uu,0];
        Uresult[uu,0]:=Uresult[vv,0];
        Uresult[vv,0]:=T;

        T:=Uresult[uu,1];
        Uresult[uu,1]:=Uresult[vv,1];
        Uresult[vv,1]:=T;

        uu:=uu+1;
        vv:=vv-1;
      end;

    end;

    if uu<r then UQsort(uu,r);
    if vv>l then UQsort(l,vv);

end;



begin
   assign(input,'roots.in');
   assign(output,'roots.out');
   reset(input);
   rewrite(output);

   read(P,K,A);
   bl:=round(sqrt(P))+1;

   Nd:=0;

   for i:=2 to bl do
     if (P-1)mod i=0 then
     begin
       Nd:=Nd+1;
       Drider[Nd]:=i;
       Nd:=Nd+1;
       Drider[Nd]:=P div i;
     end;

   for pk:=1 to 20 do
   begin
     Matches:=True;

     for i:=1 to Nd do
       if Drider[Nd]<>P-1 then
       begin
         tP:=Drider[i];
         X:=1;

         tp2N:=0;
         while tP>0 do
         begin
           tp2N:=tp2N+1;
           tp2[tp2N]:=tP mod 2;
           tP:=tP div 2;
         end;

         for j:=tp2N downto 1 do
         begin
           X:=(X*X+P)mod P;
           if tP2[j]=1
           then
             X:=(X*pk+P)mod P;
         end;

         if X=1
         then
           Matches:=False;

       end;


     if Matches then
     begin
       F:=pk;
       break;
     end;
   end;


   {A=F^z(P)}
   {z=u*bl-v}
   for u:=1 to bl do
   begin

     tP:=u*bl;
     X:=1;

     tp2N:=0;
     while tP>0 do
     begin
       tp2N:=tp2N+1;
       tp2[tp2N]:=tP mod 2;
       tP:=tP div 2;
     end;

     for j:=tp2N downto 1 do
     begin
       X:=(X*X+P)mod P;
       if tP2[j]=1
       then
         X:=(X*F+P)mod P;
     end;

     Uresult[u,0]:=X;
     Uresult[u,0]:=u;

   end;

   for v:=1 to bl do
   begin
     tP:=v;
     X:=1;

     tp2N:=0;
     while tP>0 do
     begin
       tp2N:=tp2N+1;
       tp2[tp2N]:=tP mod 2;
       tP:=tP div 2;
     end;

     for j:=tp2N downto 1 do
     begin
       X:=(X*X+P)mod P;
       if tP2[j]=1
       then
         X:=(X*F+P)mod P;
     end;

     Vresult[v,0]:=(X*A+P)mod P;
     Vresult[v,1]:=v;

   end;


   UQsort(1,bl);
   VQsort(1,bl);

   uc:=1;
   vc:=1;
   while (uc<=bl)and(vc<=bl) do
   begin

     if Uresult[uc,0]=Vresult[vc,0] then
     begin
       U:=Uresult[uc,1];
       V:=Vresult[vc,1];
       break;
     end;

     if Uresult[uc,0]>Vresult[vc,0]
     then
       vc:=vc+1
     else
       uc:=uc+1;

   end;

   Z:=(u*bl-v+P)mod P;


   N:=0;
   NN:=0;

   for i:=0 to (k-1) do
     if ((z+p-1)mod P)mod K=0
     then
     begin

       tP:=(z+p-1)div P;
       X:=1;

       tp2N:=0;
       while tP>0 do
       begin
         tp2N:=tp2N+1;
         tp2[tp2N]:=tP mod 2;
         tP:=tP div 2;
       end;

       for j:=tp2N downto 1 do
       begin
         X:=(X*X+P)mod P;
         if tP2[j]=1
         then
           X:=(X*F+P)mod P;
       end;

       NN:=NN+1;
       Ans[NN]:=X;

     end;

   for i:=1 to NN do
   begin
     N:=N+1;
     for j:=1 to i-1 do
       if Ans[i]=Ans[j] then
       begin
         Ans[i]:=-1;
         N:=N-1;
         Break;
       end;

   end;

   AQSort(1,NN);


   writeln(N);

   for i:=1 to NN do
     if Ans[i]<>-1 then
       write(Ans[i],' ');


   close(input);
   close(output);
end.
