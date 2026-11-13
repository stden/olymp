{$H+}
uses math;
var ai,jj,k,n,f_r,nf_r,f_o,nf_o,i,j,l,q:longint;
    cc,f_first,nf_first,p:array[1..10000]of longint;
    s:array[1..10000]of string;
    f_ee,f_cn,f_next,nf_ee,nf_cn,nf_next,full_p,nfull_p,full_n,nfull_n:array[1..100000]of longint;
    best:array[1..100,0..5000]of int64;
    next:array[1..100,0..5000]of record
                                   j:byte;
                                   i:word;
                                 end;
    c:char;
    answer:array[1..100]of char;
    ans,fsum,mx:int64;

procedure out(j,i:longint);
begin
  if j=0 then
    exit;
  if i=0 then
    out(j,next[j,0].i)
  else
  begin
    for l:=k-j+1 to k-j+length(s[i]) do
      answer[l]:=s[i][l-k+j];
    out(next[j,i].j,next[j,i].i);
  end;
end;

function less(la,xb,nb,xc,nc:longint):boolean;
var i:longint;
begin
  less:=true;
  for i:=length(s[la])+1 to min(xb+length(s[nb])-1,xc+length(s[nc])-1) do
  begin
    if s[nb][i-xb+1]<s[nc][i-xc+1] then
      exit;
    if s[nb][i-xb+1]>s[nc][i-xc+1] then
    begin
      less:=false;
      exit;
    end;
  end;
end;


procedure qsort_f(l,r:longint);
var i,j,c,m,t:longint;
begin
  if l<r then
  begin
    i:=l;
    j:=r;
    c:=random(r-l+1)+l;
    m:=full_p[c];
    while i<j do
    begin
      while full_p[i]<m do
        inc(i);
      while full_p[j]>m do
        dec(j);
      if i<=j then
      begin
        t:=full_p[i];
        full_p[i]:=full_p[j];
        full_p[j]:=t;
        t:=full_n[i];
        full_n[i]:=full_n[j];
        full_n[j]:=t;
        inc(i);
        dec(j);
      end;
    end;
    qsort_f(l,j);
    qsort_f(i,r);
  end;
end;
procedure qsort_nf(l,r:longint);
var i,j,c,m,t:longint;
begin
  if l<r then
  begin
    i:=l;
    j:=r;
    c:=random(r-l+1)+l;
    m:=nfull_p[c];
    while i<j do
    begin
      while nfull_p[i]<m do
        inc(i);
      while nfull_p[j]>m do
        dec(j);
      if i<=j then
      begin
        t:=nfull_p[i];
        nfull_p[i]:=nfull_p[j];
        nfull_p[j]:=t;
        t:=nfull_n[i];
        nfull_n[i]:=nfull_n[j];
        nfull_n[j]:=t;
        inc(i);
        dec(j);
      end;
    end;
    qsort_nf(l,j);
    qsort_nf(i,r);
  end;
end;

function getc(a,b,c:longint):char;
begin
  if c<=length(s[a]) then
    getc:=s[a][c]
  else
    getc:=s[b][c-length(s[a])];
end;

begin
  randomize;
  assign(input,'beauty.in');
  reset(input);
  assign(output,'beauty.out');
  rewrite(output);
  readln(n);
  for i:=1 to n do
  begin
    s[i]:='';
    while true do
    begin
      read(c);
      if not (c in ['a'..'z']) then
        break;
      s[i]:=s[i]+c;
    end;
    readln(cc[i]);
  end;
  read(k);
  f_r:=0;
  nf_r:=0;
  fillchar(next,sizeof(next),0);
  fillchar(best,sizeof(best),0);
  for i:=1 to n do
    if length(s[i])<=k then
      for j:=1 to n do
        if (length(s[j])<=k) then
        begin
          if i<>j then
          begin
            q:=0;
            p[1]:=0;
            for l:=2 to length(s[j]) do
            begin
              while (q>0)and(s[j][l]<>s[j][q+1]) do
                q:=p[q];
              if s[j][l]=s[j][q+1] then
                q:=q+1;
              p[l]:=q;
            end;
            q:=0;
            for l:=1 to length(s[i]) do
            begin
              while (q>0)and(s[i][l]<>s[j][q+1]) do
                q:=p[q];
              if s[i][l]=s[j][q+1] then
                q:=q+1;
              if q=length(s[j]) then
              begin
                f_r:=f_r+1;
                f_ee[f_r]:=j;
                f_cn[f_r]:=l-q+1;
                f_next[f_r]:=f_first[i];
                f_first[i]:=f_r;
                q:=p[q];
              end;
            end;
          end;
          q:=0;
          p[1]:=0;
          for l:=2 to length(s[i])+length(s[j]) do
          begin
            c:=getc(j,i,l);
            while (q>0)and(c<>getc(j,i,q+1)) do
              q:=p[q];
            if getc(j,i,q+1)=c then
              q:=q+1;
            p[l]:=q;
          end;
          q:=p[length(s[i])+length(s[j])];
          while q>0 do
          begin
            if (q<length(s[i]))and(q<length(s[j])) then
            begin
              inc(nf_r);
              nf_ee[nf_r]:=j;
              nf_cn[nf_r]:=q;
              nf_next[nf_r]:=nf_first[i];
              nf_first[i]:=nf_r;
            end;
            q:=p[q];
          end;
        end;
  for j:=1 to k do
  begin
    mx:=0;
    for i:=1 to n do
      if length(s[i])<=j then
      begin
        f_o:=0;
        jj:=f_first[i];
        while jj<>0 do
        begin
          inc(f_o);
          full_n[f_o]:=f_ee[jj];
          full_p[f_o]:=f_cn[jj];
          jj:=f_next[jj];
        end;
        qsort_f(1,f_o);
        nf_o:=0;
        jj:=nf_first[i];
        while jj<>0 do
        begin
          inc(nf_o);
          nfull_n[nf_o]:=nf_ee[jj];
          nfull_p[nf_o]:=length(s[i])-nf_cn[jj]+1;
          jj:=nf_next[jj];
        end;
        qsort_nf(1,nf_o);
        best[j,i]:=0;
        fsum:=cc[i];
        l:=0;
        for jj:=1 to nf_o do
        begin
          while (l+1<=f_o)and(full_p[l+1]<nfull_p[jj]) do
          begin
            l:=l+1;
            fsum:=fsum+cc[full_n[l]];
          end;
          if best[j-(nfull_p[jj]-1),nfull_n[jj]]+fsum>best[j,i] then
          begin
            best[j,i]:=best[j-(nfull_p[jj]-1),nfull_n[jj]]+fsum;
            next[j,i].j:=j-(nfull_p[jj]-1);
            next[j,i].i:=nfull_n[jj];
          end
          else
          if best[j-(nfull_p[jj]-1),nfull_n[jj]]+fsum=best[j,i] then
            if less(length(s[j]),nfull_p[jj],nfull_n[jj],j-next[j,i].i+1,next[j,i].i) then
            begin
              next[j,i].j:=j-(nfull_p[jj]-1);
              next[j,i].i:=nfull_n[jj];
            end;
        end;
        while (l+1<=f_o) do
        begin
          l:=l+1;
          fsum:=fsum+cc[full_n[l]];
        end;
        if best[j-length(s[i]),0]+fsum>best[j,i] then
        begin
          best[j,i]:=best[j-length(s[i]),0]+fsum;
          next[j,i].j:=j-length(s[i]);
          next[j,i].i:=0;
        end;
        if best[j,i]>best[j,0] then
        begin
          best[j,0]:=best[j,i];
          next[j,0].j:=j;
          next[j,0].i:=i;
        end
        else
        if best[j,i]=best[j,0] then
          if less(0,1,i,1,next[j,0].i) then
          begin
            next[j,0].j:=j;
            next[j,0].i:=i;
          end;
      end;
  end;
  ans:=0;
  for i:=1 to k do
    if best[i,0]>ans then
    begin
      ans:=best[i,0];
      ai:=i;
    end;
  writeln(ans);
  for i:=1 to k-ai do
    answer[i]:='a';
  out(ai,0);
  for i:=1 to k do
    write(answer[i]);
  close(output);
  close(input);
end.
