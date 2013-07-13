type qq=array [1..51,1..8] of longint;
type rr=array [1..2,1..51] of longint;
var n,s:qq;
    ma:array[1..51,1..51] of longint;
    ku:rr;
    i,j,kn,km,kk,v,x,y,tt,sum:longint;
    bu,bu1:text;

procedure prov(var ki:rr;var g:integer);
begin
        g:=0;
        for j:=1 to kk do
        begin
            if ki[1,j]<>0 then g:=g+1;
        end;
end;

procedure prov2(ki:rr;var a,ss:longint);
var prr:integer;
begin
        prr:=0;
        for j:=1 to kk do
            if ki[2,j]=a then
               prr:=prr+1;
        if prr=1 then ss:=ss-ki[2,j];
end;

procedure pro({var} x:longint;{ var}  y:longint;var  min:longint;var sum:longint;{var} ku:rr);
var g:integer;
    ss:longint;
begin

     prov(ku,g);
     if kk=g then
     begin
        if sum<=min then min:=sum;
     end;
     if ma[x,y]=0 then
     begin
            y:=y+1;
            { if x=2 then x:=x-1;}
            if (x>kn) or (y>kn) then
             begin
                  exit;
             end;


             pro(x,y,min,sum,ku);

     end;
  {   if (y>n) or (x>n) then break;}
     while (y<kn) and (x<kn) do
     begin
          ss:=ma[x,y];
          for i:=1 to kk do
          begin
              if n[y,i]>0 then
              if (n[y,i]-ku[1,i]+ss<0) or (ku[1,i]=0) then
              begin
              {  prov2(ku,ku[2,i],ss);}
                sum:=sum-ku[1,i]+n[y,i]+ss;
                ku[1,i]:=n[i,y];
                ku[2,i]:=ma[x,y];
                ss:=0;
              end;
          end;

          sum:=sum+ss;
          ss:=x;
          x:=y;
          y:=ss+1;
         { x:=x+1; }
          pro(y,x,min,sum,ku);
          x:=x+1;
      end;

end;




begin

     assign(bu,'armor.in');
     reset(bu);
     read(bu,kn,km,kk,v);
     for i:=1 to kn do
        for j:=1 to kk do
            read(bu,n[i,j],s[i,j]);
     for i:=1 to km do
     begin
        readln(bu,x,y,j);
        ma[x,y]:=j;
        ma[y,x]:=j;
     end;
      close(bu);

     sum:=0;
     for i:=1 to kk do
     begin
          ku[2,i]:=v;
          ku[1,i]:=n[v,i];
          sum:=sum+n[v,i];
    end;
     tt:=maxlongint;
     pro(v,v,tt,sum,ku);

     assign(bu1,'armor.out');
     rewrite(bu1);
     if tt=maxlongint then writeln(bu1,'-1')
     else
     writeln(bu1,tt);
     close(bu1);
end.