var a,t,i,l,r:longint;
    bi,bo:text;

const k=1.4142135623731;

begin

     assign(bi,'digitsum.in');
     reset(bi);
     assign(bo,'digitsum.out');
     rewrite(bo);
     readln(bi,t);
     for i:=1 to t do
     begin
          readln(bi,l,r);
          a:=trunc(k*r)-trunc(k*(l-1));
          writeln(bo,a);
     end;
     close(bi);
     close(bo);
end.
