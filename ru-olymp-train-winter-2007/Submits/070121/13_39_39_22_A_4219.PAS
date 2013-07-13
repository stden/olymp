{$Mode Delphi}
uses math;

var x:array[1..100000] of int64;
    s:array[1..100000] of int64;
    w:array[1..100000] of record
                            a,b:integer;
                            f:boolean;
                           end;
    i,n,maxg:integer;
    ch:char;
    temp:int64;


procedure recalc;
var i:integer;
begin
  s[1]:=x[1]+x[2];
  for i:=2 to maxg-1 do
    s[i]:=s[i-1]+x[i]+x[i+1];
end;

procedure add(a,b:integer);
var i:integer;
begin
  for i:=max(a-b,1) to min(min(a+b,100000),maxg) do
    x[i]:=x[i]+b-abs(i-a);
  recalc;
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
           w[i].f:=false;
           read(w[i].a,w[i].b);
           readln;
         end;
     'Q':begin
           read(ch,ch,ch,ch);
           w[i].f:=true;
           read(w[i].a,w[i].b);
           if w[i].b>maxg then
             maxg:=w[i].b;
           readln;
         end;
     end;
  end;
  for i:=1 to n do begin
    if w[i].f then begin
      temp:=abs(s[w[i].b-1]-s[w[i].a-1]);
      if odd(temp) then writeln(temp div 2,'.500')
      else writeln(temp div 2,'.000');
    end
    else begin
      add(w[i].a,w[i].b);
    end;
  end;
  close(input);
  close(output);
end.
