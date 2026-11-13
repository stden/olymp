const
        MaxN = 100000;
type
        TAct =
        record
          add : Boolean;
          x, p : LongInt;
        end;
var
        n : LongInt;
        a : Array[1 .. MaxN] of TAct;

Procedure Init;
var
        i : LongInt;
        c : Char;
begin
  ReadLn(n);
  for i := 1 to n do
  begin
    Read(c);
    if c = 'A' then
    begin
      Read(c, c);
      a[i].add := True;
      ReadLn(a[i].x, a[i].p);
    end
    else
    begin
      Read(c, c, c, c);
      a[i].add := False;
      ReadLn(a[i].x, a[i].p);
    end;
  end;
end;

Procedure Solve;
var
        i, j, l, r, m, x1, x2 : LongInt;
        rez : Real;
begin
  for i := 1 to n do
    if not a[i].add then
    begin
      rez := 0;
      x1 := a[i].x;
      x2 := a[i].p;
      for j := 1 to i - 1 do
        if a[j].add then
        begin
          l := a[j].x - a[j].p;
          m := a[j].x;
          r := a[j].x + a[j].p;
          if (x1 < r) and (x2 > l) then
          begin
            if (x1 <= l) and (x2 >= r) then
              rez := rez + a[j].p * a[j].p
            else
            begin
              if x1 <= l then
              begin
                if x2 <= m then
                  rez := rez + (a[j].p - m + x2) * (x2 - l) / 2
                else
                  rez := rez + (a[j].p * a[j].p + (x2 - m) * (2 * a[j].p - x2 + m)) / 2;
              end
              else
              begin
                if x2 >= r then
                begin
                  if x1 >= m then
                    rez := rez + (a[j].p + m - x1) * (m + a[j].p - x1) / 2
                  else
                    rez := rez + (a[j].p * a[j].p + (m - x1) * (2 * a[j].p - m + x1)) / 2
                end
                else
                begin
                  if (x1 < m) and (m < x2) then
                    rez := rez + ((m - x1) * (a[j].p + a[j].p - m + x1) + (x2 - m) * (a[j].p + a[j].p - x2 + m)) / 2
                  else
                  begin
                    if x1 < m then
                      rez := rez + (a[j].p - m + x1 + a[j].p - m + x2) * (x2 - x1) / 2
                    else
                      rez := rez + (a[j].p - x1 + m + a[j].p - x2 + m) * (x2 - x1) / 2;
                  end;
                end;
              end;
            end;
          end;
        end;
      WriteLn(rez : 0 : 3);
    end;
end;

begin
  Assign(input, 'geology.in');
  Reset(input);
  Assign(output, 'geology.out');
  Rewrite(output);
  Init;
  Solve;
  Close(input);
  Close(output);
end.
