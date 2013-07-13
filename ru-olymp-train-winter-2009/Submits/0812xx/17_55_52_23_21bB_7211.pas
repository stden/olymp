{$o+}

{H+}
{uses SysUtils;}
type
    int32=longint;
    bool=boolean;
var
   ran,f,se:array [0..200000] of int32;
   s:string;
   i,p,k,t,l,maxf,maxs:int32;

begin
     assign(input,'stress.in');
     reset(input);
     assign(output,'stress.out');
     rewrite(output);
     readln(s);
     k:=0; t:=1;
     fillchar(ran,sizeof(ran),0);
     fillchar(f,sizeof(f),0);
     fillchar(se,sizeof(se),0);
     while not eof do
     begin
          if pos('randseed = ',s)>0 then
          begin
               k:=k+1; t:=1;
               p:=pos('= ',s)+2; l:=length(s);
               for i:=p to l do
                   ran[k]:=ran[k]*10+(ord(s[i])-48);
          end;
          if pos('Work time: ',s)>0 then
          begin
              if t=1 then
              begin
                   i:=pos(': ',s)+2;
                   while s[i] in ['0'..'9'] do
                   begin
                         f[k]:=f[k]*10+(ord(s[i])-48);
                         i:=i+1;
                   end;
                   t:=2;
              end
                 else
              if t=2 then
              begin
                   i:=pos(': ',s)+2;
                   while s[i] in ['0'..'9'] do
                   begin
                        se[k]:=se[k]*10+(ord(s[i])-48);
                        i:=i+1;
                   end;
              end;
          end;
          readln(s);
     end;
     maxf:=1;
     for i:=2 to k do
         if f[i]>f[maxf] then maxf:=i;
     maxs:=1;
     for i:=2 to k do
         if se[i]>se[maxs] then maxs:=i;
     for i:=1 to k do
     begin
          writeln('At randseed = ',ran[i]);
          writeln('First: ',f[i],' ms');
          writeln('Second: ',se[i],' ms');
     end;
     writeln('Maximal work time for first: ',f[maxf],' at randseed = ',ran[maxf]);
     writeln('Maximal work time for second: ',se[maxs],' at randseed = ',ran[maxs]);
end.
