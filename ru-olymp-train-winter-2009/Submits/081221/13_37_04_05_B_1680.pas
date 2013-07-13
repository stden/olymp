uses treeunit;
type integer=longint;
procedure swap(var a,b:integer);
var c:integer;
begin
        c:=a;a:=b;b:=c;
end;
var
        v1,v2:array[1..200000]of integer;
        p,kol,nump:array[0..200000]of integer;
        c:array[0..200000,1..5]of integer;
        i,n,q,root,a,b,tek,center,an,up:integer;
        path,kpath:array[1..200000]of integer;
begin
        randseed:=random(2000000000);
        init;
        n:=GetN;
        for i:=1 to n-1 do begin
                a:=GetA(i);
                b:=GetB(i);
                if a>b then begin
                        v1[i]:=b;
                        v2[i]:=a;
                end else begin
                        v1[i]:=a;
                        v2[i]:=b;
                end;
        end;
        root:=1;
        for i:=1 to n-1 do begin
                inc(kol[v1[i]]);
                c[v1[i],kol[v1[i]]]:=v2[i];
                p[v2[i]]:=v1[i];
                nump[v2[i]]:=i;
        end;
        while kol[root]<>0 do begin
                tek:=root;i:=1;path[1]:=tek;
                while kol[tek]<>0 do begin
                        inc(i);
                        q:=random(kol[tek])+1;
                        tek:=c[tek,q];
                        kpath[i]:=q;
                        path[i]:=tek;
                end;
                center:=path[i div 2+1];
                an:=query(nump[center]);
                up:=geta(nump[center]);
               // if (root=center)and(random(7)=0)then report(root);
                if up<>center then an:=1-an;
                if an=0 then root:=center else begin
                        swap(c[nump[center],kpath[p[center]]],c[nump[center],kol[p[center]]]);
                        dec(kol[p[center]]);
                end;
        end;
        report(root);
end.
