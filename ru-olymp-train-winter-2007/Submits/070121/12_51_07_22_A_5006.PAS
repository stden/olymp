{$Mode Delphi}
uses math;

var x:array[1..100000] of int64;
    i,n,a,b:integer;
    ch:char;

procedure add(a,b:integer);
var i:integer;
begin
  for i:=max(a-b,1) to min(a+b,100000) do 
    x[i]:=x[i]+b-abs(i-a);
end;

function getans(a,b:integer):int64;
var i:integer;
begin
  result:=0;
  for i:=a to b-1 do
  result:=result+min(x[i],x[i+1])*2+(max(x[i],x[i+1])-min(x[i],x[i+1]));
end;

begin
  assign(input,'geology.in');
  assign(output,'geology.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=1 to n do begin
    read(ch);
    case ch of
     'A':begin
           read(ch,ch);
           read(a,b);
           add(a,b);
           readln;
         end;
     'Q':begin
           read(ch,ch,ch,ch);
           read(a,b);
           writeln(getans(a,b)/2:0:3);
           readln;
         end;
     end;
  end;
  close(input);
  close(output);
end.