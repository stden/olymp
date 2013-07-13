{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
uses testjury;
const MaxM=10000;


var f:file;
    b:array [0..8191] of char;
    p:array [1..MaxM] of integer;
    pr:array [1..MaxM] of char;
    be, bc, m, curc, curr, k, qp:integer;
    n:longint;
    last13, intext:boolean;

begin
  assign (f, 'kmp.in'); reset (f, 1);
  ao ('kmp.out');
  be:=8192; bc:=be; curc:=1; curr:=1;
  repeat
    while bc<be do begin
      if last13 and (b[bc]<>#10) then quit (_fail, '#13 requires #10');
      case b[bc] of
        #32: inc (curc);
        #13: last13:=true;
        #10: begin
               if not last13 then quit (_fail, '#10 requires #13');
               inc (curr);
               curc:=1;
               last13:=false;
             end;
        '*':begin
              if intext then quit (_fail, 'text second entering');
              intext:=true;
              if m<=0 then quit (_fail, 'illegal substring');
              k:=0;
            end;
        '!'..#$29, #$2b..#$7e:begin
              if not intext then begin
                inc (m);
                if m>MaxM then quit (_fail, 'too big substring');
                pr[m]:=b[bc];
                if m=1 then k:=0 else begin
                  while (k>0) and (pr[k+1]<>pr[m]) do k:=p[k];
                  if pr[k+1]=pr[m] then inc (k);
                end;
                p[m]:=k;
              end else begin
                inc (n);
                if n>200000 then quit (_fail, 'n>200000!');
                while (k>0) and (pr[k+1]<>b[bc]) do k:=p[k];
                if pr[k+1]=b[bc] then inc (k);
                if k=m then begin
                  writeln (n-m+1);
                  k:=p[k];
                end;
              end;
              inc (curc);
            end;
        else quit (_fail, 'unexpected symbol'+c2s (b[bc]));
      end;
      inc (bc);
    end;
    blockread (f, b, sizeof (b), be);
    bc:=0;
  until be=0;
  if (not intext) or (n<=0) then quit (_fail, 'негде искать');
end.