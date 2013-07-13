var p:array [0..1024] of longint;
    b:array [0..1024] of boolean;
    s,m,n,k,x,y,g,ma,i:longint;
    bi,bo:text;

begin

     assign(bi,'marked.in');
     reset(bi);
     read(bi,n,x,y);
   {  for i:=0 to (1 shl n)-1 do
         b[i]:=false; }
     for g:=1 to x do
     begin
          read(bi,k);
          if k=0 then
          begin
               b[0]:=true;
               break;
          end;
          for i:=0 to k-1 do
              read(bi,p[i]);
          m:=1 shl k;
          for s:=0 to m-1 do
          begin
               ma:=0;
               for i:=0 to k-1 do
                  if (s and (1 shl i))>0 then ma:=ma+(1 shl (p[i]-1));
               b[ma]:=true;
          end;
     end;
     for g:=1 to y do
     begin
          read(bi,k);
          if k=0 then
          begin
               b[0]:=false;
               break;
          end;
          for i:=0 to k-1 do
              read(bi,p[i]);
          m:=1 shl k;
          for s:=0 to m-1 do
          begin
               ma:=0;
               for i:=0 to k-1 do
                  if (s and (1 shl i))>0 then ma:=ma+(1 shl (p[i]-1));
               b[ma]:=false;
          end;
     end;
     close(bi);
     ma:=0;
     for i:=0 to (1 shl n)-1 do
         if b[i]=true then ma:=ma+1;;

     assign(bo,'marked.out');
     rewrite(bo);
     writeln(bo,ma);
     close(bo);
end.