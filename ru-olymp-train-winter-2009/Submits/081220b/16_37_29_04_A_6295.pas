program apb;

type tmass = array[0..10000]of integer;

var s1,s2,s3:string;
    a,b,c:tmass;
    i:integer;

function bigger(x,y:tmass):boolean;
var i0:integer;
begin

 bigger:=false;
 if x[0]<y[0] then exit;
 if x[0]>y[0] then
                   begin
                    bigger:=true;
                    exit;
                   end;
 for i0:=x[0] downto 1 do
 begin
   if x[i0]<y[i0] then
                       exit;
   if x[i0]>y[i0] then
                    begin
                     bigger:=true;
                     exit;
                    end;
 end;

 bigger:=true;

end;

begin
 assign(input,'aplusminusb.in');
 reset(input);
 assign(output,'aplusminusb.out');
 rewrite(output);

  readln(s1);
  readln(s2);

  a[0]:=length(s1);
  b[0]:=length(s2);

  for i:=1 to a[0] do
   a[a[0]-i+1]:=ord(s1[i])-ord('0');

  for i:=1 to b[0] do
   b[b[0]-i+1]:=ord(s2[i])-ord('0');

  if not bigger(a,b) then
                           begin
                            write('-');
                            c:=a;
                            a:=b;
                            b:=c;
                           end;
  fillchar(c,sizeof(c),0);
  c[0]:=a[0];
 for i:=1 to a[0] do
  begin
   c[i]:=c[i]+a[i]-b[i];
   if c[i]<0 then
                  begin
                   inc(c[i],10);
                   dec(c[i+1]);
                  end;

  end;

  while (c[0]>1)and(c[c[0]]=0) do dec(c[0]);
  for i:=c[0] downto 1 do
   write(c[i]);



 close(input);
 close(output);
end.