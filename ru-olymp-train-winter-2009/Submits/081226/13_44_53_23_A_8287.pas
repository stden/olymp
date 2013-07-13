type
    int32=longint;
    bool=boolean;

var
   n,l,r,sum,q,i:int32;
   s1,s2:string;

begin
     assign(input,'digitsum.in');
     reset(input);
     assign(output,'digitsum.out');
     rewrite(output);
     readln(n);
     s1:='1'; i:=1; s2:='';
     while i<=length(s1) do
     begin
         if s1[i]='1' then s2:=s2+'11212';
         if s1[i]='2' then s2:=s2+'1121212';
         i:=i+1;
     end;
     i:=1; s1:='';
     while i<=length(s2) do
     begin
         if s2[i]='1' then s1:=s1+'11212';
         if s2[i]='2' then s1:=s1+'1121212';
         i:=i+1;
     end;
     i:=1; s2:='';
     while i<=length(s1) do
     begin
         if s1[i]='1' then s2:=s2+'11212';
         if s1[i]='2' then s2:=s2+'1121212';
         i:=i+1;
     end;
     i:=1; s1:='';
     while i<=length(s2) do
     begin
         if s2[i]='1' then s1:=s1+'11212';
         if s2[i]='2' then s1:=s1+'1121212';
         i:=i+1;
     end;
     i:=1; s2:='';
     while i<=length(s1) do
     begin
         if s1[i]='1' then s2:=s2+'11212';
         if s1[i]='2' then s2:=s2+'1121212';
         i:=i+1;
     end;
     i:=1; s1:='';
     while i<=length(s2) do
     begin
         if s2[i]='1' then s1:=s1+'11212';
         if s2[i]='2' then s1:=s1+'1121212';
         i:=i+1;
     end;

     for i:=1 to n do
     begin
          readln(l,r);
          sum:=0;
          for q:=l to r do
              if s1[q]='1' then sum:=sum+1
                          else sum:=sum+2;
          writeln(sum);
     end;
end.
