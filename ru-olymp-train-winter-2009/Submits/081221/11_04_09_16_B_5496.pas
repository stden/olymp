program  Project1;

uses treeunit;

type TBow=
     record
       A,ai: longint;
       B,bi: longint;
     end;

var N,i,A,B,k,V,U,F,Visited: longint;
    Bow: array [0..200000] of TBow;
    Head: array [1..200000] of longint;
    Body,Tail: array [1..400000] of longint;
    Visit: array [0..200000] of longint;


procedure iDFS(Q: longint);
var W,l,x: longint;
begin

    V:=V+1;
    Visit[Q]:=Visited;

    l:=Head[Q];
    while l<>0 do
    begin
      x:=Body[l];

      if Bow[x].A=Q
      then
      begin
        {B}
        if not(Visit[Bow[x].B]=Visited) then
        begin
          W:=V;
          iDFS(Bow[x].B);
          Bow[x].bi:=V-W;
        end;
      end
      else
      begin
        {A}
        if not(Visit[Bow[x].A]=Visited) then
        begin
          W:=V;
          iDFS(Bow[x].A);
          Bow[x].ai:=V-W;
        end;
      end;

      l:=Tail[l];
    end;


end;


procedure UfDFS(Q: longint);
var l,x: longint;
begin

    Visit[Q]:=Visited;

    l:=Head[Q];
    while l<>0 do
    begin
      x:=Body[l];

      if Bow[x].A=Q
      then
      begin
        {B}
        if not(Visit[Bow[x].B]=Visited) then
        begin
          if abs(Bow[x].bi-Bow[x].ai)<abs(Bow[U].bi-Bow[U].ai)
          then
            U:=x;
          UfDFS(Bow[x].B);
        end;
      end
      else
      begin
        {A}
        if not(Visit[Bow[x].A]=Visited) then
        begin
          if abs(Bow[x].bi-Bow[x].ai)<abs(Bow[U].bi-Bow[U].ai)
          then
            U:=x;
          UfDFS(Bow[x].A);
        end;
      end;

      l:=Tail[l];
    end;

end;


begin
                     {
   assign(input,'division.in');
   assign(output,'division.out');
   reset(input);
   rewrite(output);  }

   init;

   N:=GetN;
   for i:=1 to N do
     Head[i]:=0;

   k:=0;
   for i:=1 to N-1 do
   begin
     A:=GetA(i);
     B:=GetB(i);
     Bow[i].A:=A;
     Bow[i].B:=B;
     Bow[i].ai:=0;
     Bow[i].bi:=0;

     k:=k+1;
     Body[k]:=i;
     Tail[k]:=Head[A];
     Head[A]:=k;

     k:=k+1;
     Body[k]:=i;
     Tail[k]:=Head[B];
     Head[B]:=k;
   end;
   Bow[0].A:=0;
   Bow[0].B:=0;
   Bow[0].ai:=maxint;
   Bow[0].bi:=0;

   F:=N;
   U:=1;

   for i:=1 to N do
     Visit[i]:=0;
   Visited:=0;

   while U>0 do
   begin

     Visited:=Visited+1;
     Visit[0]:=Visited;

     V:=0;
     iDFS(N);
     for i:=1 to N-1 do
     begin
       if Bow[i].ai=0
       then
         Bow[i].ai:=N-Bow[i].bi;
       if Bow[i].bi=0
       then
         Bow[i].bi:=N-Bow[i].ai;
     end;

     U:=0;
     Visited:=Visited+1;
     Visit[0]:=Visited;
     UfDFS(F);

     if U<>0 then
     begin

       if query(U)=0
       then
       begin
         F:=Bow[U].A;
       end
       else
       begin
         F:=Bow[U].B;
       end;
       Bow[U]:=Bow[0];

     end;


   end;

   report(F);




                     {
   close(input);
   close(output);
                     }
end.
