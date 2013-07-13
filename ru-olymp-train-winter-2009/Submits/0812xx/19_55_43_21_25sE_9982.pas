{$Q+,R+,I+,O-}
type integer=longint;
var a:array[0..1025] of boolean;
    n,x,y,i,j,s,m,t,q,k,w,z,ch:longint;
    p:array[0..1025] of integer;
begin
    assign(input,'marked.in');
    reset(input);
    readln(n,x,y);
    assign(output,'marked.out');
    rewrite(output);

    if x=0 then begin
          writeln('0');
          close(output);
          exit;
    end;


    for q:=1 to x do begin
       read(k);

        for w:=0 to k-1 do
             read(p[w]);

        if k=0 then begin
            a[0]:=true;
            continue;
        end;

        z:=1 shl (p[0]-1);

        for i:=1 to k-1 do
             z:=z or (1 shl (p[i]-1));

         m:=1 shl n;
         for s:=0 to m-1 do
             if (s and z)=s then begin
                a[s]:=true;
             end;
         {writeln(z,' ',m);
         readln;  }
     end;

     if y=0 then begin
             for i:=0 to m-1 do
                if a[i]=true then inc(ch);
             writeln(ch);
             close(output);
             halt;
     end;

     for q:=1 to y do begin
          read(k);
          for w:=0 to k-1 do
              read(p[w]);

          if k=0 then begin
             a[0]:=false;
             continue;
          end;

          z:=1 shl (p[0]-1);

          for i:=1 to k-1 do
              z:=z or (1 shl (p[i]-1));

          m:=1 shl n;
          for s:=0 to m-1 do
              if (z and s)=s then a[s]:=false;

          readln;
     end;

    close(input);
    ch:=0;

    for i:=0 to m-1 do
        if a[i]=true then inc(ch);
     write(ch);
     close(output);
end.

