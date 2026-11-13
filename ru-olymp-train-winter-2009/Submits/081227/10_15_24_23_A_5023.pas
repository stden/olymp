type
    int32=longint;
    bool=boolean;


var
   s,fi,fo:string;
   op,inp,ran,wr,dt,fin,fout:bool;
   k,i:int32;

begin
     assign(input,'help.in');
     reset(input);
     assign(output,'help.out');
     rewrite(output);
     readln(s); op:=false; inp:=false;
     ran:=false; wr:=false; dt:=false; k:=1;
     fin:=false; fout:=false;
     while not eof do
     begin
          if pos(' := ',s)>0 then dt:=true;
          if pos('assign(output,',s)>0 then
          begin
               op:=true;
               i:=pos('assign(output,',s)+13;
               while s[i]<>'''' do i:=i+1;
               i:=i+1;
               fo:='';
               while s[i]<>'.' do
               begin
                    fo:=fo+s[i];
                    i:=i+1;
               end;
               i:=i+1;
               if pos('.out',s)>0 then fout:=true;
          end;
          if pos('assign(input,',s)>0 then
          begin
               inp:=true;
               i:=pos('assign(input,',s)+13;
               while s[i]<>'''' do i:=i+1;
               i:=i+1;
               fi:='';
               while s[i]<>'.' do
               begin
                    fi:=fi+s[i];
                    i:=i+1;
               end;
               i:=i+1;
               if pos('.in',s)>0 then fin:=true;
          end;
          {if pos('randseed',s)>0 then ran:=true;}
          if (pos('write',s)>0)and(pos('random',s)>0) then wr:=true;
          readln(s);
          k:=k+1;
     end;
     if wr then writeln('YES')
           else
     {if (not inp)and(op) then writeln('YES')
           else}
     {if k<=25 then writeln('YES')
           else}
     if not ((fi=fo)and(fin)and(fout)) then writeln('YES')
        else
     {if dt then writeln('YES')
           else}
   {  if ran then writeln('YES')
           else} writeln('NO');
end.
