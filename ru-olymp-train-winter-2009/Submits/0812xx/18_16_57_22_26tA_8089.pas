{$N+}
var a:int64;
    i,t:longint;
    bi,bo:text;
    k,l,r:extended;
{const k=1.4142135623731;}

begin

     assign(bi,'digitsum.in');
     reset(bi);
     assign(bo,'digitsum.out');
     rewrite(bo);
     readln(bi,t);
     k:=sqrt(2);
     for i:=1 to t do
     begin
          l:=0;
          r:=0;
          readln(bi,l,r);
          r:=r*k;
          l:=k*(l-1);
          a:=trunc(r)-trunc(l);
          writeln(bo,a);
     end;
     close(bi);
     close(bo);
end.
