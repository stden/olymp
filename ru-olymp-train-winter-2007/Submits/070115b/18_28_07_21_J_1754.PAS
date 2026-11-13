Program prg;

const
  taskname = 'path';
  inf = 1000000000;

type
  integer = longint;

var
  n, m: integer;
  i, j, k: integer;
  a, b: integer;
  d, l, l2: array[0..30010] of integer;
  t1, t2: array[0..400010] of integer;
  c, arr: array[0..800010] of integer;
  tc: array[0..400010] of integer;
  min, mini: integer;
  red: array[0..30010] of boolean;




begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  read(n, m);
  for i:=1 to m do begin
    read(a, b, tc[i]);
    inc(l[a]);
    inc(l[b]);
    t1[i]:=a;
    t2[i]:=b;
  end;
  for i:=1 to n do begin
    l[i]:=l[i]+l[i-1];
  end;
  for i:=1 to n do l2[i]:=l[i-1];

  for i:=1 to m do begin
    arr[l2[t1[i]]]:=t2[i];
    c[l2[t1[i]]]:=tc[i];
    inc(l2[t1[i]]);
    arr[l2[t2[i]]]:=t1[i];
    c[l2[t2[i]]]:=tc[i];
    inc(l2[t2[i]]);
  end;



  for i:=2 to n do d[i]:=inf;

  while true do begin
    min:=inf;
    mini:=-1;
    for i:=1 to n do begin
      if (not red[i]) then begin
        if (d[i] < min) then begin
          min:=d[i];
          mini:=i;
        end;
      end;
    end;
    if (mini = -1) then break;
    red[mini]:=true;
    for i:=l[mini-1] to l[mini]-1 do begin
      if (not red[arr[i]]) then
        a:=d[mini]+c[i];
        if (d[arr[i]] > a) then begin
          d[arr[i]]:=a;
        end;
    end;
  end;

  for i:=1 to n do write(d[i], ' ');


  close(input);
  close(output);
end.
