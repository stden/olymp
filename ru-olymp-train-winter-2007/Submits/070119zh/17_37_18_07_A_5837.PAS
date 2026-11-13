var
d:array[0..40,0..40]of int64;
s:string;
zakr:array[0..40]of char;
len:integer;
procedure find(n,k:integer;a:int64);
begin
  if (n=0) and (k=0) then begin
    writeln(s);
    close(input);
    close(output);
    halt;
  end;
//    '('
  if d[n-1,k+1]>=a then begin
    s:=s+'(';
    inc(len);
    zakr[len]:='(';
    find(n-1,k+1,a);
  end;
//    ')'
  dec(a,d[n-1,k+1]);
  if (k>0) and (zakr[len]='(') and (d[n-1,k-1]>=a) then begin
    s:=s+')';
    dec(len);
    find(n-1,k-1,a);
  end;
  if(zakr[len]='(') and ( k>0) then dec(a,d[n-1,k-1]);
//   '['

  if d[n-1,k+1]>=a then begin
    s:=s+'[';
    inc(len);
    zakr[len]:='[';
    find(n-1,k+1,a);
  end;
  dec(a,d[n-1,k+1]);

//  ']'
  if (k>0) and (zakr[len]='[') and (d[n-1,k-1]>=a) then begin
    s:=s+']';
    dec(len);
    find(n-1,k-1,a);
  end;
end;
var
i,k:integer;
a:int64;
n:integer;
begin
  assign(input,'parenth.in');
  assign(output,'parenth.out');
  reset(input);
  rewrite(output);
  read(n,a);
  d[0,0]:=1;
  for i:=1 to 2*n do d[0,i]:=0;
  for i:=1 to 2*n do begin
    for k:=0 to 2*n do begin
      d[i,k]:=2*d[i-1,k+1];
      if k>0 then d[i,k]:=d[i,k]+d[i-1,k-1];
    end;
  end;
  s:='';
  len:=0;
  zakr[0]:='x';
  find(2*n,0,a);
  writeln(s);
  close(input);
  close(output);
end.
