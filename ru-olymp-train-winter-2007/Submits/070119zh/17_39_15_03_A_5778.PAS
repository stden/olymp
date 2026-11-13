{$M 16000000}
{$B-,I+,Q+,R+,S+}
//{$B-,I-,Q-,R-,S-}
const
 maxN = 2*20;
type
 int  = longint;
var
 d:array[-1..maxN+1,-1..maxN+1]of int64;
 res,s:array[1..maxN]of char;
 n,i,k:int;
 L:int64;

procedure add(ch:char);
begin
 if (k>0)and(((s[k]='(')and(ch=')'))OR((s[k]='[')and(ch=']'))) then begin
  dec(k)
 end else begin
  inc(k);
  s[k]:=ch;
 end;
end;

procedure place(i:int;L:int64);
var ck:int;
begin
 ck:=k;
 if (i=n+1) then begin
  for i:=1 to n do write(res[i]);
  exit;
 end;
 if (L <= d[n-i,ck+1]) then begin
  res[i]:='(';
  add('(');
  place(i+1, L);
  exit;
 end;
 if (k=0)or(s[k]='(') then begin
  if (L<=d[n-i,ck+1]+d[n-i,ck-1]) then begin
   res[i]:=')';
   add(res[i]);
   place(i+1, L - d[n-i,ck+1]);
  end else begin
   res[i]:='[';
   add(res[i]);
   place(i+1, L - d[n-i,ck+1]-d[n-i,ck-1]);
  end;
 end else begin
  if (L <= 2*d[n-i,ck+1]) then begin
   res[i]:='[';
   add('[');
   place(i+1, L - d[n-i,ck+1]);
  end else begin
   res[i]:=']';
   add(res[i]);
   place(i+1, L - 2*d[n-i,ck+1]);
  end;
 end;
end;

Begin
 assign(input,'parenth.in');
 reset(input);
 assign(output,'parenth.out');
 rewrite(output);
 read(n,L);
 n := 2*n;
 fillchar(d,sizeof(d),0);
 d[0,0]:=1;
 for i:=1 to n do
  for k:=0 to n do
   d[i,k] := 2*d[i-1,k+1] + d[i-1,k-1];
 k:=0;
 place(1,L);
 close(output);
End.
