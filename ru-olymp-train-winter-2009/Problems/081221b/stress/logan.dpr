var t, z, st, max1, max1r, max2, max2r, tmp:integer;
    s:string;

begin
  max1:=0; max1r:=0; max2:=0; max2r:=0; st:=0;
  repeat
    readln (s);
    if copy (s, 1, 3)='---' then st:=0;
    if copy (s, 1, 8)='randseed' then begin
      writeln ('At ', s);
      val (copy (s, 12, length (s)), randseed, tmp); assert (tmp=0);
    end;
    if copy (s, 1, 11)='Work time: ' then begin
      s:=copy (s, 12, length (s));
      z:=pos (',', s); if z<>0 then s:=copy (s, 1, z-1);
      val (s, t, tmp); assert (tmp=0);
      case st of
        0:begin 
            writeln ('First: ', t, ' ms'); 
            if t>max1 then begin max1:=t; max1r:=randseed end;
            st:=1;
          end;
        1:begin
            writeln ('Second: ', t, ' ms'); 
            if t>max2 then begin max2:=t; max2r:=randseed end;
            st:=2;
          end;
      end;
    end;
  until eof;
  writeln ('Maximal work time for first: ', max1, ' at randseed = ', max1r);
  writeln ('Maximal work time for second: ', max2, ' at randseed = ', max2r);
end.