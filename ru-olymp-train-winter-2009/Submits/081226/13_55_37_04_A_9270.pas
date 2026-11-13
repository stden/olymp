{$R+,S+,Q+,O-}


program digsum;

uses SysUtils;

type TtreeONE = record
      val,kol:int64;
      a:array[0..6]of int64;
end;

type TtreeTWO = record
      val,kol:int64;
      a:array[0..8]of int64;
end;

var one:array[1..10]of TtreeONE;
    two:array[1..10]of TtreeTWO;
    m,i,L,R:longint;
    ans:int64;

procedure firstcalc;
var i0,j0:longint;
begin

 fillchar(one,sizeof(one),0);
 fillchar(two,sizeof(two),0);

 for i0:=1 to 10 do
  begin
   one[i0].a[6]:=999999999999;
   two[i0].a[8]:=999999999999;
  end;

 one[1].val:=1;
 one[1].kol:=1;
 two[1].val:=2;
 two[1].kol:=1;
 for i0:=1 to 5 do
  begin
   one[1].a[i0]:=1;
   two[1].a[i0]:=1;
  end;
 two[1].a[6]:=1;
 two[1].a[7]:=1;

 for i0:=2 to 10 do
  begin

  one[i0].a[1]:=3*one[i0-1].a[1]+2*one[i0-1].a[3];
  one[i0].a[2]:=3*one[i0-1].a[1]+2*one[i0-1].a[3];
  one[i0].a[3]:=4*one[i0-1].a[1]+3*one[i0-1].a[3];
  one[i0].a[4]:=3*one[i0-1].a[1]+2*one[i0-1].a[3];
  one[i0].a[5]:=4*one[i0-1].a[1]+3*one[i0-1].a[3];

  two[i0].a[1]:=3*one[i0-1].a[1]+2*one[i0-1].a[3];
  two[i0].a[2]:=3*one[i0-1].a[1]+2*one[i0-1].a[3];
  two[i0].a[3]:=4*one[i0-1].a[1]+3*one[i0-1].a[3];
  two[i0].a[4]:=3*one[i0-1].a[1]+2*one[i0-1].a[3];
  two[i0].a[5]:=4*one[i0-1].a[1]+3*one[i0-1].a[3];
  two[i0].a[6]:=3*one[i0-1].a[1]+2*one[i0-1].a[3];
  two[i0].a[7]:=4*one[i0-1].a[1]+3*one[i0-1].a[3];

 for j0:=1 to 5 do
  one[i0].kol:=one[i0].a[j0];

 one[i0].val:=3*one[i0-1].val+2*two[i0-1].val;

 for j0:=1 to 7 do
  two[i0].kol:=two[i0].a[j0];
   two[i0].val:=4*one[i0-1].val+3*two[i0-1].val;


 end;

 for i0:=2 to 10 do
  begin
   for j0:=2 to 5 do
    one[i0].a[j0]:=one[i0].a[j0]+one[i0].a[j0-1];
   for j0:=2 to 7 do
    two[i0].a[j0]:=two[i0].a[j0]+two[i0].a[j0-1];
  end;


end;

function get(def,H,L,R:longint):int64;
var i0,u,v:longint;
    kkk:longint;
begin

 get:=0;

 if L>R then exit;
 if def=1 then
     begin

      if h=1 then begin
                   get:=1;
                   exit;
                  end;

      for i0:=1 to 5 do
       begin
        if L>R then exit;
        u:=1; v:=1;
        if (i0=3)or(i0=5) then begin u:=2; v:=1; end;
        if (i0=2)or(i0=4) then begin u:=1; v:=2; end;
        //into

         if ((L>=one[h].a[i0-1]+1)and(R<one[h].a[i0]))or((L>one[h].a[i0-1]+1)and(R<=one[h].a[i0])) then
                begin
                 {if i0>1 then kkk:=1 else} kkk:=0;
                 get:=get + get(u,H-1,L-one[h].a[i0-1],R-one[h].a[i0-1]-kkk);
                end;
     //cover
        if (L<=one[h].a[i0-1]+1)and(R>=one[h].a[i0]) then
                  begin
                   L:=one[h].a[i0]+1;
                   if (i0=3)or(i0=5) then get:=get+two[h].val else
                   get:=get + one[h].val;
                   continue;
                  end;
        //split
        if (L<one[h].a[i0-1]+1)and(R>one[h].a[i0])and(R<one[h].a[i0+1]-1) then
                  begin
                   get:=get + get(u,H-1,L-one[H].a[i0-1],one[h].a[i0]);
                   get:=get + get(v,H-1,one[h].a[i0]+1,R-one[h].a[i0]);
                   continue;
                  end;
       end;

     end;

 if def=2 then
     begin

       if h=1 then begin get:=2; exit; end;

      for i0:=1 to 7 do
       begin
        if L>R then exit;
        u:=1; v:=1;
        if (i0=3)or(i0=5)or(i0=7) then begin u:=2; v:=1; end;
        if (i0=2)or(i0=4)or(i0=6) then begin u:=1; v:=2; end;
        //into

         if ((L>=two[h].a[i0-1]+1)and(R<two[h].a[i0]))or((L>two[h].a[i0-1]+1)and(R<=two[h].a[i0])) then
           begin
            {if i0>1 then kkk:=1 else} kkk:=0;
            get:=get + get(u,H-1,L-two[h].a[i0-1],R-two[h].a[i0-1]-kkk);
           end;
      //cover
        if (L<=two[h].a[i0-1])and(R>=two[h].a[i0]) then
                  begin
                   L:=two[h].a[i0]+1;
                   if (i0=1)or(i0=2)or(i0=4)or(i0=6) then get:=get + one[h].val else
                   get:=get + two[h].val;
                   continue;
                  end;
        //split
        if (L<two[h].a[i0])and(R>two[h].a[i0])and(R<two[h].a[i0+1]-1) then
                  begin
                   get:=get + get(u,H-1,L-two[H].a[i0-1],two[h].a[i0]);
                   get:=get + get(v,H-1,two[h].a[i0]+1,R-two[h].a[i0]);
                   continue;
                  end;
       end;

     end;

end;


begin
 assign(input,'digitsum.in');
 reset(input);
 assign(output,'digitsum.out');
 rewrite(output);

  firstcalc;

   read(m);

 for i:=1 to m do
  begin
     read(L,R);
     ans:=get(1,10,L,R);
     writeln(ans);
   end;

 close(input);
 close(output);
end.
