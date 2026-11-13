Program prg;

const
  taskname = 'partitions';

type
  integer = longint;

label answer;

var
  i, j: integer;
  n, k: integer;
  arr: array[0..300, 0..300] of integer;
  was: array[0..300] of boolean;
  max, min: integer;
  maxold: integer;
  merging: boolean;
  a, b, c, d, e, f: integer;
  last: boolean;

begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  readln(n, k);
  while (n <> 0) or (k <> 0) do begin
    fillchar(arr, sizeof(arr), 0);
    for i:=1 to k do begin
      while (not seekeoln) do begin
        inc(arr[i][0]);
        read(arr[i][arr[i][0]]);
      end;
      readln;
    end;
    readln;

    last:=true;
    for i:=1 to k-1 do begin
      if (arr[i][0] = 2) and (arr[i][1] = i) and (arr[i][2] = n-i+1) then begin

      end else begin
        last:=false;
        break;
      end;
    end;
    if last then begin
      if ((arr[k][0] = 2) and (arr[k][1] = (n div 2)) and (arr[k][2] = (n div 2 + 1))) or (arr[k][0] = 1) and (arr[k][1] = (n div 2 + 1)) then begin
        k:=n;
        for i:=1 to n do begin
          arr[i][0]:=1;
          arr[i][1]:=i;
        end;
        goto answer;
      end;
    end;


    fillchar(was, sizeof(was), 0);

    min:=300;
    maxold:=0;
    for i:=k downto 1 do begin
      max:=0;
      merging:=false;
      b:=-1;
      for a:=1 to n do begin
        if (was[a]) and (a < arr[i][arr[i][0]]) then begin
          merging:=false;
          break;
        end else
        if (was[a]) and (b = -1) then begin
          b:=a;
          merging:=true;
        end;
      end;

      if (merging) then begin

        for j:=1 to k do begin
          for a:=1 to arr[j][0] do begin
            if (arr[j][a] = b) then begin

              {for c:=a+1 to arr[j][0] do arr[j][c-1]:=arr[j][c];
              dec(arr[j][0]);
              if (arr[j][0] = 0) then begin
                for d:=j+1 to k do begin
                  arr[d-1]:=arr[d];
                end;
                dec(k);
              end;}
              was[b]:=false;
              k:=i;
              for c:=1 to n do begin
                if (was[c]) then begin
                  inc(k);
                  arr[k][0]:=1;
                  arr[k][1]:=c;
                end;
              end;

              inc(arr[i][0]);
              arr[i][arr[i][0]]:=b;

              goto answer;
            end;
          end;
        end;

      end;

    {  min:=-1;
      for a:=1 to n do if (was[i]) then begin
        min:=a;
        break;
      end;
      if (min
     }
      for j:=arr[i][0] downto 1 do begin
        for a:=1 to n do begin
          if (was[a]) and (j <> 1) then begin
            if (a > arr[i][j]) then begin
              arr[i][0]:=j;
              was[a]:=false;
              was[arr[i][j]]:=true;
              arr[i][j]:=a;

              c:=i;
              for b:=1 to n do begin
                if (was[b]) then begin
                  inc(c);
                  arr[c][0]:=1;
                  arr[c][1]:=b;
                end;
              end;
              k:=c;

              goto answer;
            end;{ else
            if (canpart) begin
              part;
            end; }
          end;
        end;
        was[arr[i][j]]:=true;
      end;


    end;

    answer:
    writeln(n, ' ', k);
    //writeln(erroutput, n, ' ', k);
    for i:=1 to k do begin
      for j:=1 to arr[i][0] do begin
        write(arr[i][j], ' ');
        //write(erroutput, arr[i][j], ' ');
      end;
      writeln;
      //writeln(erroutput);
    end;
    
    readln(n, k);
    if (n<>0) or (k<>0) then writeln;
  end;

  close(input);
  close(output);
end.
