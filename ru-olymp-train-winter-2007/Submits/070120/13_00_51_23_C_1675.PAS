const
        MaxCol = 1000000;
type
        TBlock =
        record
          let : Char;
          len : LongInt;
          pref : Int64;
          dif : Boolean;
        end;
var
        col : LongInt;
        b : Array[0 .. MaxCol] of TBlock;
        sum : Array[1 .. MaxCol] of Int64;

Procedure PosToNum(const pos : Int64; var ind, razn : LongInt);
var
        l, r, t : LongInt;
begin
  l := 1;
  r := col;
  While l <> r do
  begin
    t := (l + r) div 2;
    if sum[t] <= pos then
      r := t
    else
      l := t + 1;
  end;
  ind := l;
  razn := sum[t] - pos + 1;
end;

Function GetPrefix(const ind, position : LongInt) : Int64;
begin
  if b[ind].dif then
    GetPrefix := b[ind].pref + position - 1
  else
    GetPrefix := b[ind].pref;
end;

Procedure Add(const c : Char; const tek : LongInt);
var
        ind, position : LongInt;
        a : Int64;
begin
  Inc(col);
    b[col].let := c;
    b[col].len := tek;
    if col = 1 then
    begin
      b[col].pref := 0;
      b[col].dif := True;
    end
    else
    begin
      posToNum(sum[col - 1], ind, position);
      While True do
      begin
        a := GetPrefix(ind, position);
        PosToNum(a, ind, position);
        if ind = 0 then
        begin
          Break;
        end
        else
        begin
          if position = b[ind].len then
          begin
            if b[ind + 1].let = c then
              Break;
          end
          else
          begin
            if c = b[ind].let then
              Break;
          end;
        end;
      end;
      if ind <> 0 then
      begin
        if b[ind].len <> position then
          Inc(position)
        else
        begin
          position := 1;
          Inc(ind);
        end;
      end
      else
      begin
        if b[1].let = c then
        begin
          ind := 1;
          position := 1;
        end;
      end;
      if b[ind].len - position < tek then
      begin
        b[col].len := b[ind].len - position
      end;
    end;
end;

Procedure Init;
var
        c : Char;
        tek : LongInt;
        ind, position : LongInt;
        a : Int64;
begin
  col := 0;
  While not EoLn do
  begin
    Read(c);
    if c in ['0' .. '9'] then
    begin
      tek := Ord(c) - Ord('0');
      Read(c);
      While c in ['0' .. '9'] do
      begin
        tek := tek * 10 + Ord(c) - Ord('0');
        Read(c);
      end;
    end
    else
      tek := 1;
    Add(c, tek);
  end;
end;

const
        MaxMax = 10000000;
var
        p : Array[1 .. MaxMax] of LongInt;
        a : Array[1 .. MaxMax] of Char;
        max : LongInt;
        ccol : LongInt;

Procedure AAdd(const c : Char; const e : LongInt);
var
        i : LongInt;
begin
  for i := 1 to e do
  begin
    Inc(ccol);
    if ccol > MaxMax then
      Break;
    a[ccol] := c;
  end;
end;

Procedure Naiv;
var
        ch : Char;
        tek, q, eee, i : LongInt;
begin
  col := 0;
  While not EoLn do
  begin
    Read(ch);
    if ch in ['0' .. '9'] then
    begin
      tek := 0;
      While ch in ['0' .. '9'] do
      begin
        tek := tek * 10 + Ord(ch) - Ord('0');
        Read(ch);
      end;
    end
    else
      tek := 1;
    AAdd(ch, tek);
  end;
  max := 1;
  p[1] := 0;
  Read(q);
  for i := 1 to q do
  begin
    Read(eee);
    if eee > MaxMax then
      WriteLn(0)
    else
    begin
      While max < eee do
      begin
        Inc(max);
        p[max] := p[max - 1];
        While (p[max] <> 0) and (a[p[max] + 1] <> a[max]) do
          p[max] := p[p[max]];
        if a[p[max] + 1] = a[max] then
          Inc(p[max]);
      end;
      WriteLn(p[eee]);
    end;
  end;
end;

begin
  Assign(input, 'rle.in');
  Reset(input);
  Assign(output, 'rle.out');
  Rewrite(output);
  Naiv;
  Close(input);
  Close(output);
end.
