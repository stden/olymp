{$H+}
var
  fl1,fmax,smax,ft,st,rfmax,rsmax,rt : longint;
  i,fl : longint;
  s1 : string;
begin
  assign(input,'stress.in');
  reset(input);
  assign(output,'stress.out');
  rewrite(output);
  fmax:=-1; smax:=-1;
  while not eof do
  begin
    readln(s1);
    fl:=0;
    for i:=1 to length(s1) do
      if s1[i]<>'-' then begin fl:=1; break; end;
    if fl=0 then begin ft:=-1; st:=-1; end;
    if fl=1 then
    begin
      if length(s1)>11 then
        if copy(s1,1,11)='randseed = ' then 
        begin 
          delete(s1,1,11);
          val(s1,rt,fl1);
          writeln('At randseed = ',rt); 
          continue; 
        end;
      if length(s1)>11 then
        if copy(s1,1,11)='Work time: ' then 
        begin 
          delete(s1,1,11);
          while s1[length(s1)]<>',' do delete(s1,length(s1),1);
          delete(s1,length(s1),1);
          if ft=-1 then 
          begin
            val(s1,ft,fl1);
            writeln('First: ',ft,' ms');
            if ft>fmax then begin fmax:=ft; rfmax:=rt; end;
          end 
                    else 
          begin
            val(s1,st,fl1);
            writeln('Second: ',st,' ms');
            if st>smax then begin smax:=st; rsmax:=rt; end;
         end; 
          continue; 
        end;
    end; 
  end;
  writeln('Maximal work time for first: ',fmax,' at randseed = ',rfmax);
  writeln('Maximal work time for second: ',smax,' at randseed = ',rsmax);
end.