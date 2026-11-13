var d:array[-1..40,0..40] of int64;
    n,i,k:integer;
    id:int64;
    st:array[1..40] of char;
    s:string;
procedure dfs(i,j:integer;k:int64);
var temp,temp2:int64;

begin
  if i>n then exit;
  if n*2-i+1=j then begin
    if st[j]='(' then
    s:=s+')';
    if st[j]='[' then
    s:=s+']';
    dfs(i+1,j-1,k);
  end
  else
  if j=0 then begin
    temp:=d[n-i,1];
    if k>temp then begin
      k:=k-temp;
      s:=s+'[';
      st[j+1]:='[';
      dfs(i+1,j+1,k);
    end
    else begin
       s:=s+'(';
       st[j+1]:='(';
       dfs(i+1,j+1,k);
    end;
  end
  else begin
    temp:=d[n-i,j+1];
    temp2:=d[n-i,j-1];
    if st[j]='(' then begin
      if k<=temp then begin
        s:=s+'(';
        st[j+1]:='(';
        dfs(i+1,j+1,k);
      end
      else if k<=temp+temp2 then begin
        s:=s+')';
        dfs(i+1,j-1,k-temp);
      end
      else begin
        s:=s+'[';
        st[j+1]:='[';
        dfs(i+1,j+1,k-temp-temp2);
      end;
    end
    else begin
      if k<=temp then begin
        s:=s+'(';
        st[j+1]:='(';
        dfs(i+1,j+1,k);
      end
      else if k<=temp*2 then begin
        s:=s+'[';
        st[j+1]:='[';
        dfs(i+1,j+1,k-temp);
      end
      else begin
        s:=s+']';
        dfs(i+1,j-1,k-temp*2);
      end;
    end;
  end;
end;

begin
  assign(input,'parenth.in');
  assign(output,'parenth.out');
  reset(input);
  rewrite(output);
  readln(n,id);
  n:=n*2;
  s:='';
  d[0,0]:=1;
  for i:=1 to n do
    for k:=0 to n do
      d[i,k]:=d[i-1,k-1]+2*d[i-1,k+1];
  dfs(1,0,id);
  writeln(s);
  close(input);
  close(output);
end.
