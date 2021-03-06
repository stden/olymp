{$I-,Q-,R-,S-}
uses math;
type tlong=array[0..200]of longint;
const base=100000;
      bl=5;
var n,i,j,ci,pi,ppi,r,k:longint;
    cnt:array[0..2,0..1000]of tlong;
    s:string;
    ans:tlong;

begin
  read(n);
  fillchar(cnt,sizeof(cnt),0);
  cnt[1,0][0]:=1;
  cnt[1,0][1]:=1;
  for i:=2 to n do
  begin
    ci:=i mod 3;
    pi:=(i+2) mod 3;
    ppi:=(i+1) mod 3;
    fillchar(cnt[ci],sizeof(cnt[ci]),0);
    for j:=1 to n do
    begin
      cnt[ci,j]:=cnt[pi,j]{+cnt[i-2,j-2]*(i-j-j div 2+1)};
      r:=0;
      cnt[ci,j][0]:=max(cnt[ci,j][0],cnt[ppi,j-2][0]);
      for k:=1 to cnt[ci,j][0] do
      begin
        cnt[ci,j][k]:=cnt[ci,j][k]+cnt[ppi,j-2][k]*(i-j-j div 2+1)+r;
        r:=cnt[ci,j][k] div base;
        cnt[ci,j][k]:=cnt[ci,j][k] mod base;
      end;
      while r<>0 do
      begin
        inc(cnt[ci,j][0]);
        cnt[ci,j][cnt[ci,j][0]]:=r mod base;
        r:=r div base;
      end;
    end;
  end;
  fillchar(ans,sizeof(ans),0);
  ci:=n mod 3;
  for i:=0 to n do
  begin
    ans[0]:=max(ans[0],cnt[ci,i][0]);
    r:=0;
    for j:=1 to ans[0] do
    begin
      ans[j]:=ans[j]+cnt[ci,i][j]+r;
      r:=ans[j] div base;
      ans[j]:=ans[j] mod base;
    end;
    while r<>0 do
    begin
      inc(ans[0]);
      ans[ans[0]]:=r mod base;
      r:=r div base;
    end;
  end;
  write(ans[ans[0]]);
  for i:=ans[0]-1 downto 1 do
  begin
    str(ans[i],s);
    while length(s)<bl do
      s:='0'+s;
    write(s);
  end;
end.
