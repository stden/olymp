type
    int32=longint;
    bool=boolean;


var
   ran,f,se:array [0..100000] of int32;
   s:string;
   i,l,p,k,maxf,maxs:int32;

begin
     assign(input,'stress.in');
     reset(input);
     assign(output,'stress.out');
     rewrite(output);
     fillchar(f,sizeof(f),0);
     fillchar(se,sizeof(se),0);
     fillchar(ran,sizeof(ran),0); k:=1;
     while not eof do
     begin
          readln(s);
          while (not eof)and(pos('randseed = ',s)<=0) do readln(s);
          l:=length(s); p:=pos('= ',s)+2;
          for i:=p to l do
              ran[k]:=ran[k]*10+(byte(s[i])-48);
          readln(s);
          while pos('Work time: ',s)<=0 do readln(s);
          p:=pos(': ',s)+2;
          i:=p;
          while (s[i]<>',')and(s[i]<>' ') do
          begin
               f[k]:=f[k]*10+(byte(s[i])-48);
               i:=i+1;
          end;
          readln(s);
          while pos('Work time: ',s)<=0 do readln(s);
          p:=pos(': ',s)+2;
          i:=p;
          while (s[i]<>',')and(s[i]<>' ') do
          begin
               se[k]:=se[k]*10+(byte(s[i])-48);
               i:=i+1;
          end;
          readln(s);
          k:=k+1;
     end;
     k:=k-1;
     for i:=1 to k do
     begin
          writeln('At randseed = ',ran[i]);
          writeln('First: ',f[i],' ms');
          writeln('Second: ',se[i],' ms');
     end;
     maxf:=1;
     for i:=2 to k do
         if f[i]>f[maxf] then maxf:=i;
     maxs:=1;
     for i:=2 to k do
         if se[i]>se[maxs] then maxs:=i;
     writeln('Maximal work time for first: ',f[maxf],' at randseed = ',ran[maxf]);
     writeln('Maximal work time for second: ',se[maxs],' at randseed = ',ran[maxs]);
end.
