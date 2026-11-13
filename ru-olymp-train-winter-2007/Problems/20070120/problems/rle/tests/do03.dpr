var
	i: longint;
begin
	writeln('10000a10000b10000a10000c10000a10000b10000a10000d10000a10000b10000a10000c10000a10000b10000a');
	writeln(1000);
	for i := 1 to 1000 do begin
		write(random(150000) + 1);
		if (i < 1000) then
			write(' ');
	end;
	writeln;
end.