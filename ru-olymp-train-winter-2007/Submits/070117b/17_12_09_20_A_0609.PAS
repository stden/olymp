var n,i:longint;
    cnt:array[0..44,'a'..'c']of int64;

begin
  assign(input,'badsubstr.in');
  reset(input);
  assign(output,'badsubstr.out');
  rewrite(output);
  read(n);
  cnt[0,'a']:=1;
  cnt[0,'b']:=0;
  cnt[0,'c']:=0;
  cnt[1,'a']:=1;
  cnt[1,'b']:=1;
  cnt[1,'c']:=1;
  for i:=2 to n do
  begin
    cnt[i,'a']:=cnt[i-1,'a']+cnt[i-1,'b']+cnt[i-1,'c'];
    cnt[i,'b']:=cnt[i-1,'b']+cnt[i-1,'c'];
    cnt[i,'c']:=cnt[i-1,'a']+cnt[i-1,'b']+cnt[i-1,'c'];
  end;
  writeln(cnt[n,'a']+cnt[n,'b']+cnt[n,'c']);
  close(output);
  close(input);
end.