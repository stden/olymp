type
    int32=longint;
    bool=boolean;


var
   s:string;
   op,inp,ran,wr,dt:bool;
   k:int32;

begin
     assign(input,'help.in');
     reset(input);
     assign(output,'help.out');
     rewrite(output);
     readln(s); op:=false; inp:=false; ran:=false; wr:=false; dt:=false; k:=1;
     while not eof do
     begin
          if pos(' := ',s)>0 then dt:=true;
          if pos('assign(output,',s)>0 then op:=true;
          if pos('assign(input,',s)>0 then inp:=true;
          {if pos('randseed',s)>0 then ran:=true;}
          if (pos('write',s)>0)and(pos('random',s)>0) then wr:=true;
          readln(s);
          k:=k+1;
     end;
     if wr then writeln('YES')
           else
     if (not inp)and(op) then writeln('YES')
           else
     if k<=25 then writeln('YES')
           else
     {if dt then writeln('YES')
           else}
   {  if ran then writeln('YES')
           else} writeln('NO');
end.
