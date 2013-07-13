var re:array[1..436,1..2] of byte;
    i,j,n,k,x,y,r,min,k1,s,smin,m:longint;
    sum:int64;
    bi,bo:text;

begin

     FillChar(re,SizeOf(re),0);
     assign(bo,'half.in');
     reset(bo);
     readln(bo,n,k);
     for i:=1 to k do
         readln(bo,re[i,1],re[i,2]);
     {for i:=0 to k-1 do
     begin
          readln(bi,x,y);
          m[x,y]:=true;
          m[y,x]:=true;
     end; }
     close(bo);


     assign(bi,'half.out');
     rewrite(bi);
     min:=maxlongint;
     m:=1 shl (n);
     s:=1;
    {for s:=0 to m-1 do
     begin}
     while s<=m-1 do
     begin
          r:=0;
          k1:=0;
          for i:=0 to n-1 do
             if (s and (1 shl i))>0 then k1:=k1+1;
          if k1=n div 2 then
          begin
              { writeln(bi,s,' ',n,' ',k1);  }
               for j:=1 to k do
               begin
                    if (s and (1 shl (re[j,1]-1))>0) and (s and (1 shl (re[j,2]-1))=0) then inc(r);
                    if (s and (1 shl (re[j,1]-1))=0) and (s and (1 shl (re[j,2]-1))>0) then inc(r);
               end;
               if r<min then
               begin
                    min:=r;
                    smin:=s;
                  {  writeln(bi,s,' ',r,' ',n,' ',k1);  }
               end;
          end;
          if min=0 then break;
          s:=s+2;
     end;

  {   assign(bo,'half.out');
     rewrite(bo);   }
     if (smin and (1 shl (0))>0) then
     begin
          for i:=0 to n-1 do
              if (smin and (1 shl (i))>0) then write(bi,i+1,' ');
     end
     else begin
        for j:=0 to n-1 do
            if (smin and (1 shl (j))=0) then write(bi,j+1,' ');
     end;
     close(bi);
end.
