{$MODE DELPHI}
uses SysUtils;

var
 s:string;
 rs,err,i:integer;
 ss,gg,ft,st:integer;
 t1,t2,p:integer;

 ok:boolean;
 mf,ms,r1,r2:integer;

begin
 assign(input, 'stress.in'); reset(input);
 assign(output, 'stress.out'); rewrite(output);

 mf:=0; ms:=0; gg:=0;
 while not eof(input) do begin
  readln(s);
  ok:=true;
  for i:=1 to length(s) do if s[i]<>'-' then begin
   ok:=false;
   break;
  end;
  if ok then inc(gg);
  if gg = 2 then begin
    writeln('At randseed = ',rs);
    writeln('First: ',ft);
    writeln('Second: ',st);
    gg:=0; ss:=0;
  end;
  if gg=0 then continue;
  if copy(s,1,11)='randseed = ' then begin
   delete(s,1,11);
   val(s,rs,err);
   if err<>0 then continue;
   ss:=0;
  end;

  if (copy(s,1,11)='Work time: ') and (copy(s,length(s)-2,3)=' ms') then begin
   delete(s,1,11);
   delete(s,length(s)-2,3);
   p:=pos(',',s);
   if p>0 then begin
    val(copy(s,1,p-1),t1,err);
    if err<>0 then continue;
    val(copy(s,p+1,length(s)-p),t2,err);
    if err<>0 then continue;
   end else begin
    val(s,t1,err);
    if err<>0 then continue;
   end;
   if (ss=0) then ft:=t1;
   if (ss=1) then st:=t1;
   inc(ss);
   if ss=2 then begin
    if mf<ft then begin
     mf:=ft;
     r1:=rs;
    end;
    if ms<st then begin
     ms:=st;
     r2:=rs;
    end;
   end;
  end;
 end;

 writeln('Maximal work time for first: ', mf, ' at randseed = ', r1);
 writeln('Maximal work time for second: ', ms, ' at randseed = ', r2);
end.
