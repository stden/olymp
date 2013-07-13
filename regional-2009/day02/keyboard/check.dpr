uses
    testlib, sysutils;
var
    line : integer; 
    no, yes : integer;
    ja, pa: string;        
begin
		line := 0;
		yes := 0;
		no := 0;
		while (not ans.seekeof) do
		begin
				inc(line);
		    ja := ans.readstring;
		    pa := ouf.readstring;

    		    if (pa <> 'yes') and (pa <> 'no') then
        		quit(_pe, '"yes" or "no" expected, "' + pa + '" found in line ' + inttostr(line));

		    if ja <> pa then
    		        quit(_wa, 'expected: ' + ja + ', found: ' + pa + ' in line ' + inttostr(line));
                    if (pa = 'yes') then
			inc(yes)
		    else
			inc(no);
		end;

		quit(_ok, 'yes = ' + inttostr(yes) + ' No = ' + inttostr(no));
end.