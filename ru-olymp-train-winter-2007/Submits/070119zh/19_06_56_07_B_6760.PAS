const
base=10000;
function min(a,b:integer):integer;
begin
  if a<b then min:=a else min:=b;
end;
var
cc:array[0..100,0..100]of integer;
x:array[0..10,0..10,0..100]of int64;
n,m,k,l:integer;
i,j:integer;
c:integer;
a,b:integer;
ans:longint;
begin
  assign(input,'rooks.in');
  reset(input);
  readln(n,m,k,l);
  close(input);
  fillchar(cc,sizeof(cc) div sizeof(integer),0);
  cc[0,0]:=1;
  for i:=1 to 100 do begin
    cc[i,0]:=1;
    for j:=1 to i do begin
      cc[i,j]:=cc[i-1,j-1]+cc[i-1,j];
      while cc[i,j]>base do  dec(cc[i,j],base);
    end;
//    cc[i,i]:=1;
  end;
  fillchar(x,sizeof(x) div sizeof(int64),0);
  x[0,0,0]:=1;
  for a:=1 to 10 do begin
    for b:=1 to 10 do begin
      for j:=1 to 100 do begin
        for i:=1 to j do begin
          for c:=0 to min(i,a) do begin
            x[a,b,j]:=x[a,b,j]+(x[a-c,b-1,j-i]*cc[a,c] mod base)*cc[a-c,i-c];
            x[a,b,j]:=x[a,b,j] mod base;
          end;
        end;
      end;
    end;
  end;

  assign(output,'rooks.out');
  rewrite(output);
  ans:=0;
  for a:=1 to n-1 do begin
    for b:=1 to m-1 do begin
      ans:=ans+(((cc[(n-a)*(m-b),l]*x[a,b,k] mod base)*cc[n,a] mod base)*cc[m,b]);
    end;
  end;
  ans:=ans mod base;
  writeln(ans);
  close(output);
end.