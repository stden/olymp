type qq=array [0..1000000] of longint;
var s:qq;
    i,j,n,p,l,r,k,t,fu:longint;
    sum:int64;
    bi,bo:text;

procedure pro(var s:qq;var k:longint);
var a:qq;
    r:longint;
begin
       r:=1;
       for i:=1 to k do
       begin
            if r>190000 then exit;
            case s[i] of
            0:begin
                   a[r]:=0;
                   a[r+1]:=0;
                   a[r+2]:=1;
                   a[r+3]:=0;
                   a[r+4]:=1;
                   r:=r+5;
              end;
            1:begin
                   a[r]:=0;
                   a[r+1]:=0;
                   a[r+2]:=1;
                   a[r+3]:=0;
                   a[r+4]:=1;
                   a[r+5]:=0;
                   a[r+6]:=1;
                   r:=r+7;
              end;
            end;
       end;
   s:=a;
   k:=r-1;
end;


begin


     k:=1;
     s[1]:=0;
     while k<=19030 do
     begin
          pro(s,k);
     end;
    { assign(bi,'digitsum.in');
     reset(bi);
     assign(bo,'digitsum.out');
     rewrite(bo);
     for i:=1 to k do
         write(bo,s[i]+1,' ');
     writeln(bo);}
     for i:=2 to k do
         s[i]:=s[i]+s[i-1];
    { writeln(k);  }
     assign(bi,'digitsum.in');
     reset(bi);
     assign(bo,'digitsum.out');
     rewrite(bo);
     readln(bi,t);
     for i:=1 to t do
     begin
          readln(bi,l,r);
          fu:=s[r]-s[l-1];
          fu:=fu+(r-l+1);
          writeln(bo,fu);
     end;
     close(bi);
     close(bo);
end.
