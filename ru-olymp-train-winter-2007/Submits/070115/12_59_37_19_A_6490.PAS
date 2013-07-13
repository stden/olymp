program cars; 

type
  Integer = Longint;

const
  MAXLEN = 1300000;
  MAXN   = 10;

type
  TArr = array [1..MAXN] of Integer;

var
  n, i, j, f, dist, tmp, x0, y0: Integer;
  dir, typ: array [1..MAXN] of char;
  x, y, xt, yt: TArr;
  b: array [0..MAXLEN] of Integer;
  q: array [0..1, 0..5*MAXLEN] of Integer;
  map: array [0..5, 0..5] of Boolean;
  spam: char;

procedure fill(i: Integer);
begin
  b[i shr 5] := b[i shr 5] or (1 shl (i and 31));
end;

function get(i: Integer): Boolean;
begin
  get := b[i shr 5] and (1 shl (i and 31)) <> 0;
end;

function len(typ: char): Integer;
begin
  if typ = 'c' then
    len := 2
  else
    len := 3;
end;

function key(const x, y: TArr): Integer;
var
  res, i: Integer;
begin
  res := 0;
  for i := 1 to n do
    if dir[i] = 'h' then
      res := res*5 + y[i]
    else
      res := res*5 + x[i];
  key := res;
end;

begin
  Assign(input, 'cars.in');
  Assign(output, 'cars.out');
  Reset(input); Rewrite(output);

  fillchar(b, sizeof(b), 0);
  ReadLn(n);
  for i := 1 to n do
    begin
      ReadLn(dir[i], x[i], y[i], spam, typ[i]);
      dec(x[i]); dec(y[i]);
    end;

  dist := 0;
  q[0,0] := 1;
  q[0,1] := key(x, y);
  fill(q[0,1]);

  while q[dist and 1,0] > 0 do
    begin
      f := dist and 1;
      q[1-f,0] := 0;
      for j := 1 to q[f,0] do
        begin
          tmp := q[f,j];
          fillchar(map, sizeof(map), 0);
          for i := n downto 1 do
            begin
              xt[i] := x[i]; yt[i] := y[i];
              if dir[i] = 'h' then
                yt[i] := tmp mod 5
              else
                xt[i] := tmp mod 5;

              map[xt[i],yt[i]] := true;
              if dir[i] = 'h' then
                if typ[i] = 'c' then
                  map[xt[i],yt[i]+1] := true
                else
                  begin
                    map[xt[i],yt[i]+1] := true;
                    map[xt[i],yt[i]+2] := true;
                  end
              else
                if typ[i] = 'c' then
                  map[xt[i]+1,yt[i]] := true
                else
                  begin
                    map[xt[i]+1,yt[i]] := true;
                    map[xt[i]+2,yt[i]] := true;
                  end;

              tmp := tmp div 5;
            end;

          if yt[1] = 4 then
            begin
              Write(dist);
              Close(input); Close(output);
              halt(0);
            end;
{
          for x0 := 0 to 5 do
            begin
              for y0 := 0 to 5 do
                Write(ord(map[x0,y0]));
              WriteLn;
            end;
          Close(input); Close(output);
          halt(0);
}
          for i := 1 to n do
            if dir[i] = 'h' then
              begin
                y0 := yt[i];
                while (yt[i] > 0) and not map[xt[i],yt[i]-1] do
                  begin
                    dec(yt[i]);
                    tmp := key(xt, yt);
                    if not get(tmp) then
                      begin
                        inc(q[1-f,0]);
                        q[1-f,q[1-f,0]] := tmp;
                        fill(tmp);
                      end;
                  end;
                yt[i] := y0;
                while (yt[i] + len(typ[i]) < 6) and not map[xt[i],yt[i]+len(typ[i])] do
                  begin
                    inc(yt[i]);
                    tmp := key(xt, yt);
                    if not get(tmp) then
                      begin
                        inc(q[1-f,0]);
                        q[1-f,q[1-f,0]] := tmp;
                        fill(tmp);
                      end;
                  end;
                yt[i] := y0;
              end
            else
              begin
                x0 := xt[i];
                while (xt[i] > 0) and not map[xt[i]-1,yt[i]] do
                  begin
                    dec(xt[i]);
                    tmp := key(xt, yt);
                    if not get(tmp) then
                      begin
                        inc(q[1-f,0]);
                        q[1-f,q[1-f,0]] := tmp;
                        fill(tmp);
                      end;
                  end;
                xt[i] := x0;
                while (xt[i] + len(typ[i]) < 6) and not map[xt[i]+len(typ[i]),yt[i]] do
                  begin
                    inc(xt[i]);
                    tmp := key(xt, yt);
                    if not get(tmp) then
                      begin
                        inc(q[1-f,0]);
                        q[1-f,q[1-f,0]] := tmp;
                        fill(tmp);
                      end;
                  end;
                xt[i] := x0;
              end;

        end;

      inc(dist);
    end;

  Write(-1);

  Close(input);
  Close(output);
end.